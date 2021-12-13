defmodule FleatureWeb.Components do
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

  def h3(assigns) do
    ~H"""
    <h3><%= render_slot(@inner_block) %></h3>
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
    # Routes.organizations_path(FleatureWeb.Endpoint, :view, organization)
    keys = Map.keys(assigns)

    ~H"""
    <div>
      <.a path={Routes.home_path(FleatureWeb.Endpoint, :index)}>Home</.a>

      <%= if :project in keys do %>
        <span>, </span>
        <.a path={Routes.organizations_path(FleatureWeb.Endpoint, :view, @project.organization)}><%= @project.organization.name %></.a>
      <% end %>

      <%= if :environment in keys do %>
        <span>, </span>
        <.a path={Routes.organizations_path(FleatureWeb.Endpoint, :view, @environment.organization)}><%= @environment.organization.name %></.a>
        <span>, </span>
        <.a path={Routes.projects_path(FleatureWeb.Endpoint, :view, @environment.project)}><%= @environment.project.name %></.a>
      <% end %>

      <%= if :feature_flag in keys do  %>
        <span>, </span>
        <.a path={Routes.organizations_path(FleatureWeb.Endpoint, :view, @feature_flag.organization)}><%= @feature_flag.organization.name %></.a>
        <span>, </span>
        <.a path={Routes.projects_path(FleatureWeb.Endpoint, :view, @feature_flag.project)}><%= @feature_flag.project.name %></.a>
        <span>, </span>
        <.a path={Routes.organizations_path(FleatureWeb.Endpoint, :view, @feature_flag.organization)}><%= @feature_flag.organization.name %></.a>
      <% end %>
    </div>
    """
  end
end
