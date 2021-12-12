defmodule FleatureWeb.EnvironmentsLive.View do
  @moduledoc false
  use FleatureWeb, :live_component

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:environment, assigns.environment)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.h1><%= @environment.name %></.h1>
      <.h2><%= @environment.project.name %></.h2>
      <.h3><%= @environment.project.organization.name %></.h3>
    </div>
    """
  end
end
