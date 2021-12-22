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

  def toggle_input(assigns) do
    value = input_value(assigns.f, assigns.key)
    translate_value = if value, do: 5, else: 0
    color = if value, do: "bg-indigo-600", else: "bg-gray-200"

    ~H"""
    <div class="flex items-center">
      <label class={"#{color} relative inline-flex flex-shrink-0 h-6 w-11 border-2 border-transparent rounded-full cursor-pointer transition-colors ease-in-out duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"} role="switch" aria-checked="false" aria-labelledby="annual-billing-label">
        <!-- Enabled: "translate-x-5", Not Enabled: "translate-x-0" -->
        <span aria-hidden="true" class={"translate-x-#{translate_value} pointer-events-none inline-block h-5 w-5 rounded-full bg-white shadow transform ring-0 transition ease-in-out duration-200"}></span>
        <%= checkbox(@f, @key, class: "invisible h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded") %>
      </label>
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
