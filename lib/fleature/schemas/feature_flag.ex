defmodule Fleature.Schemas.FeatureFlag do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "feature_flags" do
    field(:name, :string)
    field(:status, :boolean, default: false)
    belongs_to(:environment, Fleature.Schemas.Environment)
    has_many(:environment_tokens, through: [:environment, :environment_tokens])
    has_many(:feature_flag_usages, Fleature.Schemas.FeatureFlagUsage)
    has_one(:project, through: [:environment, :project])
    has_one(:organization, through: [:environment, :project, :organization])
  end

  def status_changeset(feature_flag, attrs \\ %{}) do
    feature_flag
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end

  def insert_changeset(feature_flag, attrs \\ %{}) do
    feature_flag
    |> cast(attrs, [:name, :environment_id])
    |> validate_required([:name, :environment_id])
    |> validate_format(:name, ~r/^[a-z_]+$/)
    |> unique_constraint(:name, name: :feature_flags_name_environment_id_index)
  end
end
