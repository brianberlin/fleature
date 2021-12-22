defmodule FleatureWeb.Components.Header do
  @moduledoc false
  use FleatureWeb, :components
  import FleatureWeb.Components
  alias Phoenix.LiveView.JS

  defp hashed_email(email) do
    :md5 |> :crypto.hash(email) |> Base.encode16(case: :lower)
  end

  defp menu_link(assigns) do
    method = Map.get(assigns, :method, :get)

    ~H"""
    <%= live_patch(@name, to: @to, method: method, class: "block py-2 px-4 text-sm text-gray-700") %>
    """
  end

  def menu(assigns) do
    ~H"""
    <div class="flex-shrink-0 relative ml-5">
      <div>
        <button type="button" phx-click={JS.show(to: "#user-menu")} class="bg-white rounded-full flex focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          <span class="sr-only">Open user menu</span>
          <%= if not is_nil(@user) do %>
            <img class="h-8 w-8 rounded-full" src={"https://www.gravatar.com/avatar/#{hashed_email(@user.email)}"} alt="">
          <% end %>
        </button>
      </div>

      <div
        id="user-menu"
        phx-click-away={JS.hide(to: "#user-menu")}
        phx-window-keydown={JS.hide(to: "#user-menu")}
        phx-key="escape"
        class="hidden origin-top-right absolute right-0 mt-2 w-56 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 divide-y divide-gray-100 focus:outline-none"
        tabindex="-1"
      >
        <%= if @user do %>
          <div class="px-4 py-3" role="none">
            <p class="text-sm" role="none">
              Signed in as
            </p>
            <p class="text-sm font-medium text-gray-900 truncate" role="none">
              <%= @user.email %>
            </p>
          </div>
          <div class="py-1" role="none">
            <.menu_link name="Settings" to={Routes.user_settings_path(FleatureWeb.Endpoint, :edit)} />
            <%= Phoenix.HTML.Link.link("Log out", to: Routes.user_session_path(FleatureWeb.Endpoint, :delete), method: :delete, class: "block py-2 px-4 text-sm text-gray-700") %>
          </div>
        <% else %>
          <.menu_link name="Register" to={Routes.user_registration_path(FleatureWeb.Endpoint, :new)} />
          <.menu_link name="Log In" to={Routes.user_session_path(FleatureWeb.Endpoint, :new)} />
        <% end %>
      </div>
    </div>

    """
  end

  def header(assigns) do
    ~H"""
    <div>
      <div>
        <div class="flex justify-between">
          <div>
            <%= if Map.has_key?(assigns, :back) do %>
              <nav class="sm:hidden" aria-label="Back">
                <%= live_patch(to: @back, class: "flex items-center text-sm font-medium text-gray-400 hover:text-gray-500") do %>
                  <.icon type="solid/chevron-left" size={6} />
                  Back
                <% end %>
              </nav>
            <% end %>
            <nav class="hidden sm:flex" aria-label="Breadcrumb">
              <ol role="list" class="flex items-center space-x-4">
                <%= for {breadcrumb, index} <- Enum.with_index(@breadcrumb) do %>
                  <li>
                    <div class="flex text-gray-400 items-center">
                      <%= if index !== 0 do %>
                        <.icon type="solid/chevron-right" size={5} />
                        <%= if is_nil(Map.get(breadcrumb, :to)) do %>
                          <span class="ml-4"><%= breadcrumb.title %></span>
                        <% else %>
                          <%= live_patch(breadcrumb.title, to: breadcrumb.to, class: "ml-4 text-gray-400 hover:text-gray-500") %>
                        <% end %>
                      <% else %>
                        <%= if is_nil(Map.get(breadcrumb, :to)) do %>
                          <span class="text-gray-400"><%= breadcrumb.title %></span>
                        <% else %>
                          <%= live_patch(breadcrumb.title, to: breadcrumb.to, class: "text-gray-400 hover:text-gray-500") %>
                        <% end %>
                      <% end %>
                    </div>
                  </li>
                <% end %>
              </ol>
            </nav>
          </div>
        </div>
      </div>
      <div class="mt-2 md:flex md:items-center md:justify-between">
        <div class="flex-1 min-w-0">
          <.h2 class="mt-0"><%= @title %></.h2>
        </div>
        <div class="mt-4 flex-shrink-0 flex md:mt-0 md:ml-4">
          <%= render_slot(@inner_block) %>
          <.menu user={@user} />
        </div>
      </div>
    </div>
    """
  end
end
