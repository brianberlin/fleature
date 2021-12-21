defmodule FleatureWeb.ProjectsLive.View do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.Environments

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:project, assigns.project)
      |> assign_environments()

    {:ok, socket}
  end

  defp assign_environments(socket) do
    environments = Environments.list_environments(project_id: socket.assigns.project.id)
    assign(socket, :environments, environments)
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.h1><%= @project.name %></.h1>
      <.breadcrumbs project={@project} />
      <.h2>Environments</.h2>
      <.table rows={@environments}>
        <:col let={environment} label="Name">
          <.patch_link to={Routes.environments_path(FleatureWeb.Endpoint, :view, environment)}>
            <%= environment.name %>
          </.patch_link>
        </:col>
        <:col let={environment} label="Actions">
          <.click_link
            class={"delete_environment_#{environment.id}"}
            click="delete_environment"
            id={environment.id}
            target={@myself}
          >Delete</.click_link>
        </:col>
      </.table>
      <.patch_link
        class="create-environment"
        to={Routes.environments_path(FleatureWeb.Endpoint, :create, @project)}
      >Create Environment</.patch_link>
    </.container>
    """
  end

  def handle_event("delete_environment", %{"id" => id}, socket) do
    environment = Environments.get_environment(id: id)
    Environments.delete_environment(environment)

    {:noreply, assign_environments(socket)}
  end
end
