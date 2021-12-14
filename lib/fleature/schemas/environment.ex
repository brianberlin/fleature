defmodule Fleature.Schemas.Environment do
  use Ecto.Schema

  import Ecto.Changeset

  schema "environments" do
    field(:name, :string)
    belongs_to(:project, Fleature.Schemas.Project)
    has_many(:environment_tokens, Fleature.Schemas.EnvironmentToken)
    has_one(:organization, through: [:project, :organization])
  end

  def insert_changeset(project, attrs \\ %{}) do
    project
    |> cast(attrs, [:name, :project_id])
    |> validate_required([:name, :project_id])
  end
end
