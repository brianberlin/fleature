defmodule Fleature.Schemas.Environment do
  use Ecto.Schema

  schema "environments" do
    field(:name, :string)
    belongs_to(:project, Fleature.Schemas.Project)
    has_one(:organization, through: [:project, :organization])
  end
end
