defmodule FleatureWeb.AppLive do
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
    {:ok, push_redirect(socket, to: Routes.live_path(FleatureWeb.Endpoint, FleatureWeb.HomeLive))}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <%= if not is_nil(@user) do %>
      <.header title="Organizations" user={@user}>
        <:breadcrumb title="Home" />
        <.link patch button to={Routes.organizations_path(FleatureWeb.Endpoint, :create)} class="create-organization">Create Organization</.link>
      </.header>

      <.table rows={@organizations}>
        <:col let={organization} label="Name">
          <.link
            patch
            class={"organization-link-#{organization.id}"}
            to={Routes.organizations_path(FleatureWeb.Endpoint, :view, organization)}
          >
            <%= organization.name %>
          </.link>
        </:col>
        <:col let={organization} label="Actions" class="w-2/12">
          <.link
            button secondary small patch
            class={"edit_organization_#{organization.id}"}
            to={Routes.organizations_path(FleatureWeb.Endpoint, :edit, organization)}
          >Edit</.link>
          <.link
            button secondary small
            class={"delete_organization_#{organization.id}"}
            click="delete_organization"
            id={organization.id}
            data={[confirm: "Are you sure?"]}
          >Delete</.link>
        </:col>
      </.table>
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
