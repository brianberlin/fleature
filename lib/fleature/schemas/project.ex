defmodule Fleature.Schemas.Project do
  use Ecto.Schema

  alias Fleature.Schemas.Organization

  schema "projects" do
    field(:name, :string)
    belongs_to(:organization, Organization)
    has_many(:users, through: [:organization, :users])
  end
end
