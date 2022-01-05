defmodule FleatureWeb.Components.Links do
  @moduledoc false
  use FleatureWeb, :components

  import FleatureWeb.Components

  def link(%{patch: true} = assigns) do
    class = get_classes(assigns, classes(assigns))

    ~H"""
      <%= live_patch(to: @to, class: class) do %>
        <%= render_slot(@inner_block) %>
      <% end %>
    """
  end

  def link(%{click: _} = assigns) do
    target = Map.get(assigns, :target)
    class = get_classes(assigns, classes(assigns))
    data = Map.get(assigns, :data, [])

    ~H"""
    <a
      href="#"
      class={class}
      phx-click={@click}
      phx-value-id={@id}
      phx-target={target}
      data={data}
    ><%= render_slot(@inner_block) %></a>
    """
  end

  def link(assigns) do
    target = Map.get(assigns, :target, "_blank")
    class = get_classes(assigns, classes(assigns))
    data = Map.get(assigns, :data, [])

    ~H"""
    <a
      href={@to}
      class={class}
      target={target}
      data={data}
    ><%= render_slot(@inner_block) %></a>
    """
  end

  def classes(%{button: true, secondary: true, small: true}) do
    """
    inline-flex items-center px-2.5 py-1.5 border border-gray-300 shadow-sm text-xs font-medium rounded
    text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500
    """
  end

  def classes(%{button: true, secondary: true}) do
    """
    inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium
    text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500
    """
  end

  def classes(%{button: true, small: true}) do
    """
      inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded shadow-sm
      text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500
    """
  end

  def classes(%{button: true}) do
    """
    inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium
    text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500
    """
  end

  def classes(_) do
    "text-indigo-600 hover:text-indigo-500"
  end
end
