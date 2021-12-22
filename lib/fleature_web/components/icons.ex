defmodule FleatureWeb.Components.Icons do
  @moduledoc false
  use FleatureWeb, :components
  import FleatureWeb.Components

  def icon(assigns) do
    size = Map.get(assigns, :size, 5)
    class = get_classes(assigns, "h-#{size} w-#{size}")

    case Map.get(assigns, :type) do
      "outline/plus-sm" ->
        ~H"""
        <svg xmlns="http://www.w3.org/2000/svg" class={"h-#{@size} w-#{@size}"} fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
        </svg>
        """

      "solid/folder" ->
        ~H"""
        <svg xmlns="http://www.w3.org/2000/svg" class={class} viewBox="0 0 20 20" fill="currentColor">
          <path d="M2 6a2 2 0 012-2h5l2 2h5a2 2 0 012 2v6a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" />
        </svg>
        """

      "solid/collection" ->
        ~H"""
        <svg xmlns="http://www.w3.org/2000/svg" class={class} viewBox="0 0 20 20" fill="currentColor">
          <path d="M7 3a1 1 0 000 2h6a1 1 0 100-2H7zM4 7a1 1 0 011-1h10a1 1 0 110 2H5a1 1 0 01-1-1zM2 11a2 2 0 012-2h12a2 2 0 012 2v4a2 2 0 01-2 2H4a2 2 0 01-2-2v-4z" />
        </svg>
        """

      "solid/chevron-right" ->
        ~H"""
        <svg xmlns="http://www.w3.org/2000/svg" class={class} viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
        </svg>
        """

      "solid/chevron-left" ->
        ~H"""
        <svg xmlns="http://www.w3.org/2000/svg" class={class} viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
        </svg>
        """
    end
  end
end
