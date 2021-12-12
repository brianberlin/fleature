defmodule FleatureWeb.Components.Type do
  @moduledoc false
  use FleatureWeb, :components
  import Phoenix.HTML.Form
  import FleatureWeb.ErrorHelpers

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

  def a(assigns) do
    ~H"""
    <%= live_patch(to: @path, class: Map.get(assigns, :class)) do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  def submit_button(assigns) do
    ~H"""
    <%= submit do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  def text_input(assigns) do
    ~H"""
    <%= label @f, @key %>
    <%= text_input @f, @key %>
    <%= error_tag @f, @key %>
    """
  end

  def hidden_input(assigns) do
    ~H"""
    <%= hidden_input(@f, @key, value: @value) %>
    """
  end

  def breadcrumbs(assigns) do
    ~H"""
    <div>
      <%= for link <- @links do  %>
        <.a path={link.path}><%= link.title  %></.a>
      <% end %>
    </div>
    """
  end
end
