defmodule FleatureWeb.LiveViews.Home do
  @moduledoc """
  Home Page
  """

  use FleatureWeb, :live_view

  alias Fleature.Organizations

  def mount(_params, session, socket) do
    user = Fleature.Accounts.get_user_by_session_token(session["user_token"])
    organizations = Organizations.list_organizations([user_id: user.id])

    socket =
      socket
      |> assign(:organizations, organizations)
      |> assign(:user, user)

    {:ok, socket, temporary_assigns: [organizations: [], user: nil]}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <.h1>Welcome to Fleature</.h1>
    <.h2>Organizations</.h2>
    <.ul>
      <%= for organization <- @organizations do %>
        <.li><%= organization.name %></.li>
      <% end %>
    </.ul>
    """
  end
end
