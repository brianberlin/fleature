defmodule FleatureWeb.OrganizationsLive.Create do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.Organizations
  alias Fleature.Schemas.Organization

  def update(assigns, socket) do
    changeset = Organization.insert_changeset(%Organization{}, assigns.user)

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:user, assigns.user)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form_container>
        <:header>
          <.h2>Create an Organization</.h2>
        </:header>
        <:body>
          <.form class="organization-form" let={f} for={@changeset} phx-change="validate" phx-submit="save" phx-target={@myself}>
            <.text_input f={f} key={:name} />
            <.submit_button>Save</.submit_button>
          </.form>
        </:body>
      </.form_container>
    </div>
    """
  end

  def handle_event("validate", %{"organization" => params}, socket) do
    changeset = Organization.insert_changeset(%Organization{}, socket.assigns.user, params)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"organization" => params}, socket) do
    case Organizations.insert_organization(socket.assigns.user, params) do
      {:ok, _organization} ->
        path = Routes.home_path(FleatureWeb.Endpoint, :index)
        {:noreply, push_redirect(socket, to: path)}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
