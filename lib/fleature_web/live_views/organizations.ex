defmodule FleatureWeb.OrganizationsLive do
  @moduledoc false
  use FleatureWeb, :live_view

  alias Fleature.Accounts
  alias Fleature.Organizations

  def mount(_, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    {:ok, assign(socket, :current_user, user)}
  end

  def render(assigns) do
    ~H"""
    <%= case @live_action do %>
    <% :create -> %>
      <.live_component
        module={FleatureWeb.OrganizationsLive.Create}
        id="create"
        user={@current_user}
      />
    <% :view -> %>
      <.live_component
        module={FleatureWeb.OrganizationsLive.View}
        id="view"
        organization={@organization}
      />
    <% end %>
    """
  end

  def handle_params(%{"organization_id" => id}, _url, socket) do
    organization = Organizations.get_organization(id: id)
    {:noreply, assign(socket, :organization, organization)}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end
end
