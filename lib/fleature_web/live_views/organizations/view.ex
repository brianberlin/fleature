defmodule FleatureWeb.OrganizationsLive.View do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.Projects

  def update(assigns, socket) do
    projects = Projects.list_projects(organization_id: assigns.organization.id)

    socket =
      socket
      |> assign(:projects, projects)
      |> assign(:organization, assigns.organization)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.h1><%= @organization.name %></.h1>
      <.ul>
        <%= for project <- @projects do %>
          <.li>
            <.a path={Routes.projects_path(FleatureWeb.Endpoint, :view, @organization, project)}>
              <%= project.name %>
            </.a>
          </.li>
        <% end %>
      </.ul>
      <.a
        class="create-project"
        path={Routes.projects_path(FleatureWeb.Endpoint, :create, @organization)}
      >Create Project</.a>
    </div>
    """
  end
end
