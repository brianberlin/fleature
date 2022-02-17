defmodule FleatureWeb.FeatureFlagController do
  @moduledoc false
  use FleatureWeb, :controller

  alias Fleature.FeatureFlags
  alias Fleature.FeatureFlagUsages

  def subscribe(conn, %{"client_id" => client_id}) do
    conn
    |> put_format("text/event-stream")
    |> SsePhoenixPubsub.stream({Fleature.PubSub, [client_id]})
  end

  def list(conn, %{"client_id" => client_id}) do
    feature_flags = FeatureFlags.list_feature_flags(client_id: client_id)
    json(conn, feature_flags)
  end

  def usage(conn, params) do
    params
    |> FeatureFlagUsages.new(queue: :default, max_attempts: 1)
    |> Oban.insert()

    json(conn, %{ok: true})
  end
end
