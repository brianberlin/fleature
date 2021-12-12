defmodule Fleature.Schemas.Project do
  use Ecto.Schema

  import Ecto.Changeset

  alias Fleature.Schemas.Organization

  schema "projects" do
    field(:name, :string)
    belongs_to(:organization, Organization)
    has_many(:users, through: [:organization, :users])
  end

  def insert_changeset(project, attrs \\ %{}) do
    project
    |> cast(attrs, [:name, :organization_id])
    |> validate_required([:name, :organization_id])
  end
end
