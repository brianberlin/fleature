defmodule FleatureTestWeb.HomeLive do
  use FleatureTestWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>Test</div>
    <p><%= Fleature.enabled?("test") %></p>
    """
  end
end
