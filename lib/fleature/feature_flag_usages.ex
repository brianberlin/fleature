defmodule Fleature.FeatureFlagUsages do
  @moduledoc false
  use Oban.Worker, queue: :default

  import Ecto.Query

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

  def data_feature_flag_usages(environment_id) do
    datetime = DateTime.add(DateTime.utc_now(), -24 * 60 * 60, :second)

    result =
      Repo.transaction(fn ->
        FeatureFlagUsage
        |> where([ffu], ffu.recorded_at >= ^datetime)
        |> where(environment_id: ^environment_id)
        |> join(:left, [ffu], feature_flag in assoc(ffu, :feature_flag))
        |> select([ffu, ff], %{
          name: ff.name,
          count: sum(ffu.count),
          recorded_at: fragment("date_trunc('minute', ?)", ffu.recorded_at)
        })
        |> group_by([ffu], fragment("date_trunc('minute', ?)", ffu.recorded_at))
        |> group_by([_, ff], ff.name)
        |> Repo.stream()
        |> Stream.scan({[], [], []}, fn row, {time, count, name} ->
          new_time = row.recorded_at |> DateTime.from_naive!("Etc/UTC") |> DateTime.to_iso8601()

          {[new_time] ++ time, [row.count] ++ count, [row.name] ++ name}
        end)
        |> Stream.take(-1)
        |> Enum.to_list()
      end)

    case result do
      {:ok, [{times, counts, names}]} ->
        %{"Time" => times, "Count" => counts, "Feature Flags" => names}

      _ ->
        %{"Time" => [], "Count" => [], "Feature Flags" => []}
    end
  end
end
