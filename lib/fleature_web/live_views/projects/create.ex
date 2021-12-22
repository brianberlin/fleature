defmodule FleatureWeb.ProjectsLive.Create do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.Projects
  alias Fleature.Schemas.Project

  def update(assigns, socket) do
    changeset =
      Project.insert_changeset(%Project{}, %{
        organization_id: assigns.organization.id
      })

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:organization, assigns.organization)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form_container>
        <:header>
          <.h1>Create a Project</.h1>
        </:header>
        <:body>
          <.form class="project-form" let={f} for={@changeset} phx-change="validate" phx-submit="save" phx-target={@myself}>
            <.text_input f={f} key={:name} />
            <.hidden_input f={f} key={:organization_id} value={@organization.id} />
            <.submit_button>Save</.submit_button>
          </.form>
        </:body>
      </.form_container>
    </div>
    """
  end

  def handle_event("validate", %{"project" => params}, socket) do
    changeset = Project.insert_changeset(%Project{}, params)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"project" => params}, socket) do
    case Projects.insert_project(params) do
      {:ok, _project} ->
        path = Routes.organizations_path(FleatureWeb.Endpoint, :view, socket.assigns.organization)
        {:noreply, push_redirect(socket, to: path)}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
