defmodule FleatureWeb.Components.Breadcrumbs do
  @moduledoc false
  use FleatureWeb, :components

  import FleatureWeb.Components

  def breadcrumbs(assigns) do
    keys = Map.keys(assigns)

    ~H"""
    <div class={get_classes(assigns, "")}>
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
