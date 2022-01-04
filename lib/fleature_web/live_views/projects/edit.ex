defmodule FleatureWeb.ProjectsLive.Edit do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.Projects
  alias Fleature.Schemas.Project

  def update(assigns, socket) do
    changeset = Ecto.Changeset.change(assigns.project, %{})

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:user, assigns.user)
      |> assign(:project, assigns.project)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form_container>
        <:header>
          <.h2><%= @project.name %></.h2>
        </:header>
        <:body>
          <.form class="project-form" let={f} for={@changeset} phx-change="validate" phx-submit="save" phx-target={@myself}>
            <.text_input f={f} key={:name} />
            <.submit_button>Save</.submit_button>
          </.form>
        </:body>
      </.form_container>
    </div>
    """
  end

  def handle_event("validate", %{"project" => params}, socket) do
    changeset = Project.update_changeset(socket.assigns.project, params)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"project" => params}, socket) do
    case Projects.update_project(socket.assigns.project, params) do
      {:ok, project} ->
        path = Routes.organizations_path(FleatureWeb.Endpoint, :view, project.organization_id)
        {:noreply, push_redirect(socket, to: path)}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
