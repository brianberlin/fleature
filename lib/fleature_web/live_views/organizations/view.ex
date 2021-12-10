defmodule FleatureWeb.OrganizationsLive.View do
  @moduledoc false
  use FleatureWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <.h1><%= @organization.name %></.h1>
    </div>
    """
  end
end
