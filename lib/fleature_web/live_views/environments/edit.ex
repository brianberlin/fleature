defmodule FleatureWeb.EnvironmentsLive.Edit do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.Environments
  alias Fleature.Schemas.Environment

  def update(assigns, socket) do
    changeset = Ecto.Changeset.change(assigns.environment, %{})

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:user, assigns.user)
      |> assign(:environment, assigns.environment)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form_container>
        <:header>
          <.h2><%= @environment.name %></.h2>
        </:header>
        <:body>
          <.form class="environment-form" let={f} for={@changeset} phx-change="validate" phx-submit="save" phx-target={@myself}>
            <.text_input f={f} key={:name} />
            <.submit_button>Save</.submit_button>
          </.form>
        </:body>
      </.form_container>
    </div>
    """
  end

  def handle_event("validate", %{"environment" => params}, socket) do
    changeset = Environment.update_changeset(socket.assigns.environment, params)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"environment" => params}, socket) do
    case Environments.update_environment(socket.assigns.environment, params) do
      {:ok, environment} ->
        path = Routes.projects_path(FleatureWeb.Endpoint, :view, environment.project_id)
        {:noreply, push_redirect(socket, to: path)}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
