defmodule Fleature.Schemas.Project do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "projects" do
    field(:name, :string)
    belongs_to(:organization, Fleature.Schemas.Organization)
    has_many(:users, through: [:organization, :users])
  end

  def insert_changeset(project, attrs \\ %{}) do
    project
    |> cast(attrs, [:name, :organization_id])
    |> validate_required([:name, :organization_id])
  end
end
