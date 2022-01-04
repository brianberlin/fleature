defmodule FleatureWeb.ProjectsLive.View do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.Environments

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:project, assigns.project)
      |> assign(:user, assigns.user)
      |> assign_environments()

    {:ok, socket}
  end

  defp assign_environments(socket) do
    environments = Environments.list_environments(project_id: socket.assigns.project.id)
    assign(socket, :environments, environments)
  end

  def render(assigns) do
    ~H"""
    <div>
      <.container>
        <.header title="Environments" back={Routes.organizations_path(FleatureWeb.Endpoint, :view, @project.organization)} user={@user}>
          <:breadcrumb title="Home" to={Routes.home_path(FleatureWeb.Endpoint, :index)} />
          <:breadcrumb title={@project.organization.name} to={Routes.organizations_path(FleatureWeb.Endpoint, :view, @project.organization)} />
          <:breadcrumb title={@project.name} />
          <.link patch button to={Routes.environments_path(FleatureWeb.Endpoint, :create, @project)}>Create Environment</.link>
        </.header>

        <.table rows={@environments}>
          <:col let={environment} label="Name">
            <.link patch to={Routes.environments_path(FleatureWeb.Endpoint, :view, environment)}>
              <%= environment.name %>
            </.link>
          </:col>
          <:col let={environment} label="Actions" class="w-2/12">
            <.link
              button secondary small
              class={"delete_environment_#{environment.id}"}
              click="delete_environment"
              id={environment.id}
              target={@myself}
              data={[confirm: "Are you sure?"]}
            >Delete</.link>
          </:col>
        </.table>

      </.container>
    </div>
    """
  end

  def handle_event("delete_environment", %{"id" => id}, socket) do
    environment = Environments.get_environment(id: id)
    Environments.delete_environment(environment)

    {:noreply, assign_environments(socket)}
  end
end
