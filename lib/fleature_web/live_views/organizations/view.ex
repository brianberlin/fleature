defmodule FleatureWeb.OrganizationsLive.View do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.Projects

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:organization, assigns.organization)
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
      <.h1><%= @organization.name %></.h1>
      <.breadcrumbs organization={@organization} />
      <.h2>Projects</.h2>
      <.table rows={@projects}>
        <:col let={project} label="Name">
          <.patch_link to={Routes.projects_path(FleatureWeb.Endpoint, :view, project)}>
            <%= project.name %>
          </.patch_link>
        </:col>
        <:col let={project} label="Actions">
          <.click_link
            class={"delete_project_#{project.id}"}
            click="delete_project"
            id={project.id}
            target={@myself}
          >Delete</.click_link>
        </:col>
      </.table>
      <.patch_link
        class="create-project"
        to={Routes.projects_path(FleatureWeb.Endpoint, :create, @organization)}
      >Create Project</.patch_link>
    </div>
    """
  end

  def handle_event("delete_project", %{"id" => id}, socket) do
    project = Projects.get_project(id: id)
    {:ok, _} = Projects.delete_project(project)

    {:noreply, assign_projects(socket)}
  end
end
