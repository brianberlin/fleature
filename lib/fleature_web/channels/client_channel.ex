defmodule FleatureWeb.ClientChannel do
  use FleatureWeb, :channel

  alias Fleature.FeatureFlags

  @impl true
  def join("client:" <> client_id, _payload, socket) do
    Phoenix.PubSub.subscribe(Fleature.PubSub, "client:" <> client_id)
    send(self(), :update_all)
    {:ok, socket}
  end

  @impl true
  def handle_info(:update_all, socket) do
    push(socket, "update_all", feature_flag_response(socket.assigns.client_id))
    {:noreply, socket}
  end

  def handle_info({:update_one, name, status}, socket) do
    push(socket, "update_one", %{name => status})
    {:noreply, socket}
  end

  defp feature_flag_response(client_id) do
    [client_id: client_id]
    |> FeatureFlags.list_feature_flags()
    |> Enum.map(&{&1.name, &1.status})
    |> Enum.into(%{})
  end
end
