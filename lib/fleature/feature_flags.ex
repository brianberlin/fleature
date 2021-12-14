defmodule Fleature.FeatureFlags do
  import Ecto.Query

  alias Fleature.Schemas.FeatureFlag
  alias Fleature.Repo

  def update_feature_flag_status(feature_flag, attrs) do
    feature_flag
    |> FeatureFlag.status_changeset(attrs)
    |> Repo.update()
    |> broadcast_feature_flag_status()
  end

  def insert_feature_flag(attrs) do
    %FeatureFlag{}
    |> FeatureFlag.insert_changeset(attrs)
    |> Repo.insert()
  end

  def query_feature_flags(params) do
    apply_filters(FeatureFlag, params)
  end

  def get_feature_flag(params \\ [], preloads \\ []) do
    params
    |> query_feature_flags()
    |> preload(^preloads)
    |> Repo.one()
  end

  def list_feature_flags(params \\ []) when is_list(params) do
    params
    |> query_feature_flags()
    |> default_order()
    |> Repo.all()
  end

  defp filter(query, {:id, id}) do
    where(query, id: ^id)
  end

  defp filter(query, {:environment_id, id}) do
    where(query, environment_id: ^id)
  end

  defp filter(query, {:client_id, client_id}) do
    from(
      feature_flag in query,
      left_join: environment in Fleature.Schemas.Environment,
      on: feature_flag.environment_id == environment.id,
      left_join: environment_token in Fleature.Schemas.EnvironmentToken,
      on: environment_token.environment_id == environment.id,
      where: environment_token.client_id == ^client_id
    )
  end

  defp apply_filters(query, params) do
    Enum.reduce(params, query, fn param, query ->
      filter(query, param)
    end)
  end

  defp default_order(query) do
    order_by(query, [s], asc: s.name)
  end

  defp broadcast_feature_flag_status({:ok, feature_flag}) do
    feature_flag = Repo.preload(feature_flag, :environment_tokens)

    Enum.each(feature_flag.environment_tokens, fn %{client_id: client_id} ->
      Phoenix.PubSub.broadcast(Fleature.PubSub, "client:" <> client_id, :update)
    end)

    {:ok, feature_flag}
  end

  defp broadcast_feature_flag_status(response), do: response
end
