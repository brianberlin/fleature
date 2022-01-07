defmodule Fleature.FeatureFlagUsagesTest do
  use Fleature.DataCase, async: true

  test "feature flag usage" do
    environment_token = insert(:environment_token)
    feature_flag1 = insert(:feature_flag, environment: environment_token.environment)
    feature_flag2 = insert(:feature_flag, environment: environment_token.environment)
    data = %{feature_flag1.name => 1, feature_flag2.name => 2}

    Fleature.FeatureFlagUsages.perform(%{
      args: %{"client_id" => environment_token.client_id, "data" => data}
    })

    feature_flag_id1 = feature_flag1.id
    feature_flag_id2 = feature_flag2.id
    environment_id = environment_token.environment_id

    assert [
             %{
               feature_flag_id: ^feature_flag_id1,
               environment_id: ^environment_id,
               count: 1
             },
             %{
               feature_flag_id: ^feature_flag_id2,
               environment_id: ^environment_id,
               count: 2
             }
           ] = Fleature.Schemas.FeatureFlagUsage |> order_by(asc: :count) |> Fleature.Repo.all()
  end

  test "data_feature_flag_usages" do
    now = DateTime.utc_now()

    feature_flag1 = insert(:feature_flag)
    feature_flag2 = insert(:feature_flag, environment: feature_flag1.environment)

    Enum.each(20..1, fn num ->
      insert(:feature_flag_usage,
        feature_flag: feature_flag1,
        environment: feature_flag1.environment,
        count: num,
        recorded_at: DateTime.add(now, -10 * num * 60, :second)
      )

      insert(:feature_flag_usage,
        feature_flag: feature_flag2,
        environment: feature_flag1.environment,
        count: num,
        recorded_at: DateTime.add(now, -10 * num * 60, :second)
      )
    end)

    %{"Count" => count, "Time" => time, "Feature Flags" => flags} =
      Fleature.FeatureFlagUsages.data_feature_flag_usages(feature_flag1.environment_id)

    assert length(count) == 40
    assert length(time) == 40
    assert length(flags) == 40
  end
end
