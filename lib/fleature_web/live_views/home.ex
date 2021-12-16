defmodule FleatureWeb.HomeLive do
  @moduledoc """
  Home Page
  """
  use FleatureWeb, :live_view

  alias Fleature.Organizations

  def mount(_params, %{"user_token" => user_token}, socket) do
    user = Fleature.Accounts.get_user_by_session_token(user_token)
    organizations = Organizations.list_organizations(user_id: user.id)

    socket =
      socket
      |> assign(:organizations, organizations)
      |> assign(:user, user)

    {:ok, socket, temporary_assigns: [organizations: [], user: nil]}
  end

  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [organizations: [], user: nil]}
  end

  def render(assigns) do
    ~H"""
    <div>
    <.h1>Welcome to Fleature</.h1>
    <%= if not is_nil(@user) do %>
      <.h2>Organizations</.h2>
      <.ul>
        <%= for organization <- @organizations do %>
          <.li>
            <.patch_link
              class={"organization-link-#{organization.id}"}
              to={Routes.organizations_path(FleatureWeb.Endpoint, :view, organization)}
            >
              <%= organization.name %>
            </.patch_link>
          </.li>
        <% end %>
      </.ul>
      <.patch_link
        class="create-organization"
        to={Routes.organizations_path(FleatureWeb.Endpoint, :create)}
      >Create Organization</.patch_link>
    <% end %>
    </div>
    """
  end
end
