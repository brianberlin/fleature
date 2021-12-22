defmodule FleatureWeb.Components.Containers do
  @moduledoc false
  use FleatureWeb, :components

  import FleatureWeb.Components

  def container(assigns) do
    class = get_classes(assigns, "bg-gray-200 box-content px-5 py-5 font-sans")

    ~H"""
    <div class={class}><%= render_slot(@inner_block) %></div>
    """
  end

  def form_container(assigns) do
    class =
      get_classes(
        assigns,
        "min-h-full flex flex-col justify-center py-12 sm:px-6 lg:px-8"
      )

    ~H"""
    <div class={class}>
      <%= for header <- @header do %>
        <div class="sm:mx-auto sm:w-full sm:max-w-md">
          <%= render_slot(header) %>
        </div>
      <% end %>
      <%= for body <- @body do %>
        <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
          <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
            <%= render_slot(body) %>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
end
