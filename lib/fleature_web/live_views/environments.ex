defmodule FleatureWeb.EnvironmentsLive do
  @moduledoc false

  use FleatureWeb, :live_view

  alias Fleature.Accounts
  alias Fleature.Projects
  alias Fleature.Environments

  def mount(_, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    {:ok, assign(socket, :current_user, user)}
  end

  def render(assigns) do
    ~H"""
    <%= case @live_action do %>
    <% :view -> %>
      <.live_component
        module={FleatureWeb.EnvironmentsLive.View}
        id={@environment.id}
        environment={@environment}
        user_id={@current_user.id}
      />
    <% :create -> %>
      <.live_component
        module={FleatureWeb.EnvironmentsLive.Create}
        id="create"
        project={@project}
      />
    <% end %>
    """
  end

  def handle_params(%{"environment_id" => id}, _url, socket) do
    environment = Environments.get_environment([id: id], [:organization, :project])
    {:noreply, assign(socket, :environment, environment)}
  end

  def handle_params(%{"project_id" => id}, _url, socket) do
    project = Projects.get_project(id: id)
    {:noreply, assign(socket, :project, project)}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end
end
