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
      <.breadcrumbs organization={@organization} />
      <.h2>Projects</.h2>
      <.ul>
        <%= for project <- @projects do %>
          <.li>
            <.patch_link to={Routes.projects_path(FleatureWeb.Endpoint, :view, project)}>
              <%= project.name %>
            </.patch_link>
          </.li>
        <% end %>
      </.ul>
      <.patch_link
        class="create-project"
        to={Routes.projects_path(FleatureWeb.Endpoint, :create, @organization)}
      >Create Project</.patch_link>
    </div>
    """
  end
end
