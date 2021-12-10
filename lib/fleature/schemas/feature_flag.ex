defmodule Fleature.Schemas.FeatureFlag do
  use Ecto.Schema

  schema "feature_flags" do
    field(:name, :string)
    belongs_to(:environment, Fleature.Schemas.Environment)
    has_one(:project, through: [:environment, :project])
    has_one(:organization, through: [:environment, :project, :organization])
  end
end
