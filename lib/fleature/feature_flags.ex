defmodule Fleature.FeatureFlags do
  import Ecto.Query

  alias Fleature.Schemas.FeatureFlag
  alias Fleature.Repo

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

  defp apply_filters(query, params) do
    Enum.reduce(params, query, fn param, query ->
      filter(query, param)
    end)
  end

  defp default_order(query) do
    order_by(query, [s], asc: s.name)
  end
end
