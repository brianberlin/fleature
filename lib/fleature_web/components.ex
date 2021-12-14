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

  def patch_link(assigns) do
    ~H"""
    <%= live_patch(to: @to, class: Map.get(assigns, :class)) do %>
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

  def checkbox_input(assigns) do
    ~H"""
    <%= checkbox(@f, @key) %>
    """
  end

  def hidden_input(assigns) do
    required = [:f, :key]
    opts = Enum.filter(assigns, &(&1 in required))

    ~H"""
    <%= hidden_input(@f, @key, opts) %>
    """
  end

  def breadcrumbs(assigns) do
    # Routes.organizations_path(FleatureWeb.Endpoint, :view, organization)
    keys = Map.keys(assigns)

    ~H"""
    <div>
      <.patch_link to={Routes.home_path(FleatureWeb.Endpoint, :index)}>Home</.patch_link>

      <%= if :project in keys do %>
        <span>, </span>
        <.patch_link to={Routes.organizations_path(FleatureWeb.Endpoint, :view, @project.organization)}><%= @project.organization.name %></.patch_link>
      <% end %>

      <%= if :environment in keys do %>
        <span>, </span>
        <.patch_link to={Routes.organizations_path(FleatureWeb.Endpoint, :view, @environment.organization)}><%= @environment.organization.name %></.patch_link>
        <span>, </span>
        <.patch_link to={Routes.projects_path(FleatureWeb.Endpoint, :view, @environment.project)}><%= @environment.project.name %></.patch_link>
      <% end %>

      <%= if :feature_flag in keys do  %>
        <span>, </span>
        <.patch_link to={Routes.organizations_path(FleatureWeb.Endpoint, :view, @feature_flag.organization)}><%= @feature_flag.organization.name %></.patch_link>
        <span>, </span>
        <.patch_link to={Routes.projects_path(FleatureWeb.Endpoint, :view, @feature_flag.project)}><%= @feature_flag.project.name %></.patch_link>
        <span>, </span>
        <.patch_link to={Routes.organizations_path(FleatureWeb.Endpoint, :view, @feature_flag.organization)}><%= @feature_flag.organization.name %></.patch_link>
      <% end %>
    </div>
    """
  end
end
