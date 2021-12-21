defmodule FleatureWeb.Components.Links do
  @moduledoc false
  use FleatureWeb, :components

  import FleatureWeb.Components

  def patch_link(assigns) do
    class = get_classes(assigns, "text-indigo-600 hover:text-indigo-500")

    ~H"""
      <%= live_patch(to: @to, class: class) do %>
        <%= render_slot(@inner_block) %>
      <% end %>
    """
  end

  def click_link(assigns) do
    target = Map.get(assigns, :target)

    ~H"""
    <a
      href="#"
      class={@class}
      phx-click={@click}
      phx-value-id={@id}
      phx-target={target}
    ><%= render_slot(@inner_block) %></a>
    """
  end
end
