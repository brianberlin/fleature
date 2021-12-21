defmodule FleatureWeb.Components.FormElements do
  @moduledoc false
  use FleatureWeb, :components

  import FleatureWeb.Components
  import FleatureWeb.ErrorHelpers
  import Phoenix.HTML.Form

  def submit_button(assigns) do
    class =
      get_classes(
        assigns,
        "w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      )

    ~H"""
    <%= submit class: class do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  def text_input(assigns) do
    ~H"""
    <%= label @f, @key, class: "block text-sm font-medium text-gray-700" %>
    <div class="mt-1">
      <%= text_input @f, @key, class: "appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" %>
      <div class="mt-2 text-sm text-gray-500"><%= error_tag @f, @key %></div>
    </div>
    """
  end

  def email_input(assigns) do
    ~H"""
    <%= label @f, @key, class: "block text-sm font-medium text-gray-700" %>
    <div class="mt-1">
      <%= email_input @f, @key, class: "appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" %>
      <div class="mt-2 text-sm text-gray-500"><%= error_tag @f, @key %></div>
    </div>
    """
  end

  def password_input(assigns) do
    ~H"""
    <%= label @f, @key, class: "block text-sm font-medium text-gray-700" %>
    <div class="mt-1">
      <%= password_input @f, @key, class: "appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" %>
      <div class="mt-2 text-sm text-gray-500"><%= error_tag @f, @key %></div>
    </div>
    """
  end

  def checkbox_input(assigns) do
    ~H"""
    <div class="flex items-center">
      <%= checkbox(@f, @key, class: "h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded") %>
      <%= label @f, @key, class: "ml-2 block text-sm text-gray-700" %>
    </div>
    """
  end

  def hidden_input(assigns) do
    required = [:f, :key]
    opts = Enum.filter(assigns, &(&1 in required))

    ~H"""
    <%= hidden_input(@f, @key, opts) %>
    """
  end
end
