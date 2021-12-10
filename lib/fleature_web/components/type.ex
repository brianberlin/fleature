defmodule FleatureWeb.Components.Type do
  @moduledoc false
  use FleatureWeb, :components

  def h1(assigns) do
    ~H"""
    <h1><%= render_slot(@inner_block) %></h1>
    """
  end

  def p(assigns) do
    ~H"""
    <p><%= render_slot(@inner_block) %></p>
    """
  end
end
