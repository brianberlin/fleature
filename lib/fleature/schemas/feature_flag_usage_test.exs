defmodule Fleature.Schemas.FeatureFlagUsageTest do
  use Fleature.DataCase, async: true

  alias Fleature.Schemas.FeatureFlagUsage

  test "insert_changeset" do
    feature_flag = insert(:feature_flag)

    attrs = %{
      feature_flag_id: feature_flag.id,
      environment_id: feature_flag.environment_id,
      recorded_at: NaiveDateTime.utc_now(),
      count: 1
    }

    assert %Ecto.Changeset{valid?: true, changes: %{count: 1}} =
             FeatureFlagUsage.changeset(%FeatureFlagUsage{}, attrs)
  end
end
