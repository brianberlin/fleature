defmodule FleatureWeb.FeatureFlagsLive.View do
  @moduledoc false
  use FleatureWeb, :live_component

  def update(assigns, socket) do
    socket = assign(socket, :feature_flag, assigns.feature_flag)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.h1><%= @feature_flag.name %></.h1>
      <.breadcrumbs feature_flag={@feature_flag} />
    </div>
    """
  end
end
