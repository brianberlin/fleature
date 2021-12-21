defmodule FleatureWeb.HomeLive do
  @moduledoc """
  Home Page
  """
  use FleatureWeb, :live_view

  alias Fleature.Organizations

  def mount(_params, %{"user_token" => user_token}, socket) do
    user = Fleature.Accounts.get_user_by_session_token(user_token)

    socket =
      socket
      |> assign(:user, user)
      |> assign_organizations()

    {:ok, socket, temporary_assigns: [organizations: nil]}
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :user, nil), temporary_assigns: [organizations: nil]}
  end

  def render(assigns) do
    ~H"""
    <.container>
    <.h1>Welcome to Fleature</.h1>
    <%= if not is_nil(@user) do %>
      <.h2>Organizations</.h2>
      <.table rows={@organizations}>
        <:col let={organization} label="Name">
          <.patch_link
            class={"organization-link-#{organization.id}"}
            to={Routes.organizations_path(FleatureWeb.Endpoint, :view, organization)}
          >
            <%= organization.name %>
          </.patch_link>
        </:col>
        <:col let={organization} label="Actions">
          <.click_link
            class={"delete_organization_#{organization.id}"}
            click="delete_organization"
            id={organization.id}
          >Delete</.click_link>
        </:col>
      </.table>
      <.patch_link
        class="create-organization"
        to={Routes.organizations_path(FleatureWeb.Endpoint, :create)}
      >Create Organization</.patch_link>
    <% end %>
    </.container>
    """
  end

  def handle_event("delete_organization", %{"id" => id}, socket) do
    organization = Fleature.Organizations.get_organization(id: id)
    Fleature.Organizations.delete_organization(organization)
    {:noreply, assign_organizations(socket)}
  end

  defp assign_organizations(socket) do
    organizations = Organizations.list_organizations(user_id: socket.assigns.user.id)
    assign(socket, :organizations, organizations)
  end
end
