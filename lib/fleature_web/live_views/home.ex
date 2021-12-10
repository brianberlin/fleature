defmodule FleatureWeb.HomeLive do
  @moduledoc """
  Home Page
  """
  use FleatureWeb, :live_view

  alias Fleature.Organizations

  def mount(_params, session, socket) do
    user = Fleature.Accounts.get_user_by_session_token(session["user_token"])
    organizations = Organizations.list_organizations(user_id: user.id)

    socket =
      socket
      |> assign(:organizations, organizations)
      |> assign(:user, user)

    {:ok, socket, temporary_assigns: [organizations: [], user: nil]}
  end

  def render(assigns) do
    ~H"""
    <div>
    <.h1>Welcome to Fleature</.h1>
    <.h2>Organizations</.h2>
    <.ul>
      <%= for organization <- @organizations do %>
        <.li>
          <.a
            class={"organization-link-#{organization.id}"}
            path={Routes.organizations_path(FleatureWeb.Endpoint, :view, organization)}
          >
            <%= organization.name %>
          </.a>
        </.li>
      <% end %>
    </.ul>
    <.a
      class="create-organization"
      path={Routes.organizations_path(FleatureWeb.Endpoint, :create)}
    >Create Organization</.a>
    </div>
    """
  end
end
