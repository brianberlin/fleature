defmodule Fleature.Schemas.Environment do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "environments" do
    field(:name, :string)
    belongs_to(:project, Fleature.Schemas.Project)
    has_many(:environment_tokens, Fleature.Schemas.EnvironmentToken)
    has_many(:feature_flags, Fleature.Schemas.FeatureFlag)
    has_many(:feature_flag_usages, through: [:feature_flags, :feature_flag_usages])
    has_one(:organization, through: [:project, :organization])
  end

  def insert_changeset(project, attrs \\ %{}) do
    project
    |> cast(attrs, [:name, :project_id])
    |> validate_required([:name, :project_id])
  end

  def update_changeset(environment, attrs \\ %{}) do
    environment
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
