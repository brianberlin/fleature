defmodule FleatureWeb.OrganizationsLive.Create do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.Schemas.Organization
  alias Fleature.Organizations

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.h1>Create an Organization</.h1>
      <.form class="organization-form" let={f} for={changeset(@user)} phx-change="validate" phx-submit="save" phx-target={@myself}>
        <.text_input f={f} key={:name} />
        <.submit_button>Save</.submit_button>
      </.form>
    </div>
    """
  end

  defp changeset(user) do
    Organization.insert_changeset(%Organization{}, user)
  end

  def handle_event("validate", %{"organization" => params}, socket) do
    changeset = Organization.insert_changeset(%Organization{}, socket.assigns.user, params)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"organization" => params}, socket) do
    case Organizations.insert_organization(socket.assigns.user, params) do
      {:ok, organization} ->
        path = Routes.organizations_path(FleatureWeb.Endpoint, :view, organization)
        {:noreply, push_patch(socket, to: path)}

      {:error, changeset} ->
        IO.inspect(changeset)

        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
