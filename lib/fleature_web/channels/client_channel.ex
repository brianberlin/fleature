defmodule FleatureWeb.ClientChannel do
  use FleatureWeb, :channel

  alias Fleature.FeatureFlags

  @impl true
  def join("client:" <> client_id, _payload, socket) do
    Phoenix.PubSub.subscribe(Fleature.PubSub, "client:" <> client_id)
    send(self(), :update)
    {:ok, socket}
  end

  @impl true
  def handle_info(:update, socket) do
    push(socket, "update", feature_flag_response(socket.assigns.client_id))
    {:noreply, socket}
  end

  defp feature_flag_response(client_id) do
    [client_id: client_id]
    |> FeatureFlags.list_feature_flags()
    |> Enum.map(&{&1.name, &1.status})
    |> Enum.into(%{})
  end
end
