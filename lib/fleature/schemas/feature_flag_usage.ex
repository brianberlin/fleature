defmodule Fleature.Schemas.FeatureFlagUsage do
  use Ecto.Schema

  import Ecto.Changeset

  schema "feature_flag_usages" do
    field(:count, :integer)
    field(:recorded_at, :naive_datetime)
    belongs_to(:environment, Fleature.Schemas.Environment)
    belongs_to(:feature_flag, Fleature.Schemas.FeatureFlag)
  end

  @fields [:count, :recorded_at, :environment_id, :feature_flag_id]

  def changeset(feature_flag_usage, attrs) do
    feature_flag_usage
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
