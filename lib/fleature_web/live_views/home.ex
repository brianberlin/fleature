defmodule FleatureWeb.LiveViews.Home do
  @moduledoc """
  Home Page
  """

  use FleatureWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.h1>Welcome to Fleature</.h1>
    """
  end
end
