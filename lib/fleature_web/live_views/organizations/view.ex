defmodule FleatureWeb.OrganizationsLive.View do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.Projects

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:organization, assigns.organization)
      |> assign(:user, assigns.user)
      |> assign_projects()

    {:ok, socket}
  end

  defp assign_projects(socket) do
    projects = Projects.list_projects(organization_id: socket.assigns.organization.id)
    assign(socket, :projects, projects)
  end

  def render(assigns) do
    ~H"""
    <div>
      <.container>
        <.header title="Projects" back={Routes.home_path(FleatureWeb.Endpoint, :index)} user={@user}>
          <:breadcrumb title="Home" to={Routes.home_path(FleatureWeb.Endpoint, :index)} />
          <:breadcrumb title={@organization.name} />
          <.link patch button to={Routes.projects_path(FleatureWeb.Endpoint, :create, @organization)} class="create-project">Create Project</.link>
        </.header>
        <.table rows={@projects}>
          <:col let={project} label="Name">
            <.link patch to={Routes.projects_path(FleatureWeb.Endpoint, :view, project)}>
              <%= project.name %>
            </.link>
          </:col>
          <:col let={project} label="Actions" class="w-2/12">
            <.link
              button secondary small
              class={"delete_project_#{project.id}"}
              click="delete_project"
              id={project.id}
              target={@myself}
            >Delete</.link>
          </:col>
        </.table>
      </.container>
    </div>
    """
  end

  def handle_event("delete_project", %{"id" => id}, socket) do
    project = Projects.get_project(id: id)
    {:ok, _} = Projects.delete_project(project)

    {:noreply, assign_projects(socket)}
  end
end
