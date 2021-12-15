defmodule FleatureTestWeb.HomeLive do
  use FleatureTestWeb, :live_view

  def mount(_arg1, _session, socket) do
    Fleature.subscribe()

    {:ok, assign(socket, :feature_flags, Fleature.list())}
  end

  def render(assigns) do
    ~H"""
    <div>Test</div>
    <ul>
      <%= for {name, status} <- @feature_flags do  %>
        <li><%= name %>: <%= status %></li>
      <% end %>
    </ul>
    """
  end

  def handle_info({:feature_flag, "new_feature_flag", status}, socket) do
    {:noreply, assign(socket, :new_feature_flag, status)}
  end

  def handle_info({:feature_flag, name, status}, socket) do
    feature_flags = Map.put(socket.assigns.feature_flags, name, status)

    {:noreply, assign(socket, :feature_flags, feature_flags)}
  end
end
