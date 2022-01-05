defmodule FleatureWeb.HomeLive do
  @moduledoc """
  Home Page
  """
  use FleatureWeb, :live_view

  def mount(_params, %{"user_token" => user_token}, socket) when not is_nil(user_token) do
    {:ok, push_redirect(socket, to: Routes.app_path(FleatureWeb.Endpoint, :index))}
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :user, nil)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.header title="Home" user={@user} />
      <.p>Fleature is platform for managing feature flags. The source for this site and the client packages are <.link to="https://github.com/brianberlin/fleature">available on github</.link>. </.p>
      <.h3>Features</.h3>

      <.ul>
        <.li>multiple organizations, projects, environments and environment tokens</.li>
        <.li>specify enabled flags in code</.li>
        <.li>enable/disable flags from the web interface</.li>
        <.li>see when a flag was used and the status it was in.</.li>
        <.li>gradual rollout coming soon</.li>
      </.ul>

      <.h3>Clients</.h3>
      <.ul>
        <.li><.link to="https://github.com/brianberlin/fleature_elixir">Elixir</.link></.li>
        <.li><.link to="https://github.com/brianberlin/fleature_js">Javascript</.link></.li>
      </.ul>

    </.container>
    """
  end
end
