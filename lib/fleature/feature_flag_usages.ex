defmodule Fleature.FeatureFlagUsages do
  @moduledoc false
  use Oban.Worker, queue: :default

  alias Fleature.FeatureFlags
  alias Fleature.Repo
  alias Fleature.Schemas.FeatureFlagUsage

  def perform(%{args: %{"client_id" => client_id, "data" => data}}) do
    data
    |> Map.to_list()
    |> Enum.reduce([], fn {name, count}, acc ->
      feature_flag = FeatureFlags.get_feature_flag(name: name, client_id: client_id)

      if is_nil(feature_flag) do
        acc
      else
        [{feature_flag, count}] ++ acc
      end
    end)
    |> Enum.each(fn {feature_flag, count} ->
      insert_feature_flag_usage(%{
        feature_flag_id: feature_flag.id,
        environment_id: feature_flag.environment_id,
        count: count,
        recorded_at: NaiveDateTime.utc_now()
      })
    end)

    :ok
  end

  defp insert_feature_flag_usage(attrs) do
    %FeatureFlagUsage{}
    |> FeatureFlagUsage.changeset(attrs)
    |> Repo.insert()
  end
end
