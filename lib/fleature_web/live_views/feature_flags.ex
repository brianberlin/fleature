defmodule FleatureWeb.FeatureFlagsLive do
  @moduledoc false

  use FleatureWeb, :live_view

  alias Fleature.Accounts
  alias Fleature.Environments
  alias Fleature.FeatureFlags

  def mount(_, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    socket =
      socket
      |> assign(:current_user, user)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <%= case @live_action do %>
    <% :view -> %>
      <.live_component
        module={FleatureWeb.FeatureFlagsLive.View}
        id="view"
        feature_flag={@feature_flag}
      />
    <% :create -> %>
      <.live_component
        module={FleatureWeb.FeatureFlagsLive.Create}
        id={@environment.id}
        environment={@environment}
      />
    <% end %>
    """
  end

  def handle_params(%{"feature_flag_id" => id}, _url, socket) do
    feature_flag =
      FeatureFlags.get_feature_flag([id: id], [:environment, :project, :organization])

    {:noreply, assign(socket, :feature_flag, feature_flag)}
  end

  def handle_params(%{"environment_id" => id}, _url, socket) do
    environment = Environments.get_environment([id: id], [])
    {:noreply, assign(socket, :environment, environment)}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end
end
