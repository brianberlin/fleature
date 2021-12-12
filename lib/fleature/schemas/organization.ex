defmodule Fleature.Schemas.Organization do
  use Ecto.Schema

  import Ecto.Changeset

  alias Fleature.Repo

  schema "organizations" do
    field(:name, :string)
    has_many(:projects, Fleature.Schemas.Project)
    many_to_many(:users, Fleature.Schemas.User, join_through: "users_organizations")
  end

  # def changeset(organization, attrs \\ %{}) do
  #   organization
  #   |> cast(attrs, [:name])
  #   |> validate_required([:name])
  # end

  def insert_changeset(organization, user, attrs \\ %{}) do
    organization
    |> Repo.preload(:users)
    |> cast(attrs, [:name])
    |> put_assoc(:users, [user])
    |> validate_required([:name])
  end
end
