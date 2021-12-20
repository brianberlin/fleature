defmodule Fleature.Schemas.Project do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "projects" do
    field(:name, :string)
    belongs_to(:organization, Fleature.Schemas.Organization)
    has_many(:environments, Fleature.Schemas.Environment)
    has_many(:feature_flags, through: [:environments, :feature_flags])
    has_many(:feature_flag_usages, through: [:feature_flags, :feature_flag_usages])
    has_many(:environment_tokens, through: [:environments, :environment_tokens])
    has_many(:users, through: [:organization, :users])
  end

  def insert_changeset(project, attrs \\ %{}) do
    project
    |> cast(attrs, [:name, :organization_id])
    |> validate_required([:name, :organization_id])
  end
end
