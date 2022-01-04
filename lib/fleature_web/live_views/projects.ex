defmodule FleatureWeb.ProjectsLive do
  @moduledoc false

  use FleatureWeb, :live_view

  alias Fleature.Accounts
  alias Fleature.Organizations
  alias Fleature.Projects

  def mount(_, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    {:ok, assign(socket, :user, user)}
  end

  def render(assigns) do
    ~H"""
    <%= case @live_action do %>
    <% :view -> %>
      <.live_component
        module={FleatureWeb.ProjectsLive.View}
        id="view"
        project={@project}
        user={@user}
      />
    <% :create -> %>
      <.live_component
        module={FleatureWeb.ProjectsLive.Create}
        id="create"
        organization={@organization}
        user={@user}
      />
    <% :edit -> %>
      <.live_component
        module={FleatureWeb.ProjectsLive.Edit}
        id="edit_#{@project.id}"
        project={@project}
        user={@user}
      />

    <% end %>
    """
  end

  def handle_params(%{"project_id" => id}, _url, socket) do
    project = Projects.get_project([id: id], [:organization])
    {:noreply, assign(socket, :project, project)}
  end

  def handle_params(%{"organization_id" => id}, _url, socket) do
    organization = Organizations.get_organization(id: id)
    {:noreply, assign(socket, :organization, organization)}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end
end
