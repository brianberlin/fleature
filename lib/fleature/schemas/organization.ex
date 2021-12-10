defmodule Fleature.Schemas.Organization do
  use Ecto.Schema

  schema "organizations" do
    field(:name, :string)
    has_many(:projects, Fleature.Schemas.Project)
    many_to_many(:users, Fleature.Schemas.User, join_through: "organizations_users")
  end
end
