defmodule FleatureWeb.Components.Type do
  @moduledoc false
  use FleatureWeb, :components


  def h1(assigns) do
    ~H"""
    <h1><%= render_slot(@inner_block) %></h1>
    """
  end

  def h2(assigns) do
    ~H"""
    <h2><%= render_slot(@inner_block) %></h2>
    """
  end

  def p(assigns) do
    ~H"""
    <p><%= render_slot(@inner_block) %></p>
    """
  end

  def ul(assigns) do
    ~H"""
    <ul><%= render_slot(@inner_block) %></ul>
    """
  end

  def li(assigns) do
    ~H"""
    <li><%= render_slot(@inner_block) %></li>
    """
  end

  def button(assigns) do
    ~H"""
    <%= live_patch(to: @path) do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end
end
