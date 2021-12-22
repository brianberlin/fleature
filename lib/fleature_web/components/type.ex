defmodule FleatureWeb.Components.Type do
  @moduledoc false
  use FleatureWeb, :components

  import FleatureWeb.Components

  def h1(assigns) do
    class = get_classes(assigns, "mt-8 text-4xl font-extrabold text-gray-700")

    ~H"""
    <h1 class={class}><%= render_slot(@inner_block) %></h1>
    """
  end

  def h2(assigns) do
    class =
      get_classes(
        assigns,
        "mt-6 leading-7 text-2xl font-bold text-gray-600 sm:text-3xl sm:truncate"
      )

    ~H"""
    <h2 class={class}><%= render_slot(@inner_block) %></h2>
    """
  end

  def h3(assigns) do
    class = get_classes(assigns, "mt-4 text-2xl font-extrabold text-gray-700")

    ~H"""
    <h3 class={class}><%= render_slot(@inner_block) %></h3>
    """
  end

  def p(assigns) do
    class = get_classes(assigns, "mt-2 text-sm text-gray-600")

    ~H"""
    <p class={class}><%= render_slot(@inner_block) %></p>
    """
  end

  def ul(assigns) do
    ~H"""
    <ul><%= render_slot(@inner_block) %></ul>
    """
  end

  def li(assigns) do
    ~H"""
    <li><%= render_slot(@inner_block) %></li>
    """
  end
end
