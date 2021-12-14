defmodule FleatureWeb.ProjectsLive.View do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.Environments

  def update(assigns, socket) do
    environments = Environments.list_environments(project_id: assigns.project.id)

    socket =
      socket
      |> assign(:environments, environments)
      |> assign(:project, assigns.project)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.h1><%= @project.name %></.h1>
      <.breadcrumbs project={@project} />
      <.h2>Environments</.h2>
      <.ul>
        <%= for environment <- @environments do %>
          <.li>
            <.patch_link to={Routes.environments_path(FleatureWeb.Endpoint, :view, environment)}>
              <%= environment.name %>
            </.patch_link>
          </.li>
        <% end %>
      </.ul>
      <.patch_link
        class="create-environment"
        to={Routes.environments_path(FleatureWeb.Endpoint, :create, @project)}
      >Create Environment</.patch_link>
    </div>
    """
  end
end
