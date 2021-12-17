defmodule Fleature.Schemas.FeatureFlagTest do
  use Fleature.DataCase, async: true

  alias Fleature.Schemas.FeatureFlag

  test "insert_changeset with valid name" do
    environment = insert(:environment)

    attrs = %{
      name: "test",
      environment_id: environment.id
    }

    assert %Ecto.Changeset{valid?: true, changes: %{name: "test"}} =
             FeatureFlag.insert_changeset(%FeatureFlag{}, attrs)
  end

  test "insert_changeset with invalid name" do
    environment = insert(:environment)

    attrs = %{
      name: "invalid name",
      environment_id: environment.id
    }

    assert %Ecto.Changeset{valid?: false, errors: [name: {"has invalid format", _}]} =
             FeatureFlag.insert_changeset(%FeatureFlag{}, attrs)
  end

  test "unique names" do
    feature_flag = insert(:feature_flag)

    attrs = %{
      name: feature_flag.name,
      environment_id: feature_flag.environment_id
    }

    assert {:error, %{valid?: false, errors: [name: {"has already been taken", _}]}} =
             %FeatureFlag{} |> FeatureFlag.insert_changeset(attrs) |> Repo.insert()
  end
end
