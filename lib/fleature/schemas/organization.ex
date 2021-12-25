defmodule Fleature.Schemas.Organization do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias Fleature.Repo

  schema "organizations" do
    field(:name, :string)
    has_many(:projects, Fleature.Schemas.Project)
    has_many(:environments, through: [:projects, :environments])
    has_many(:feature_flags, through: [:environments, :feature_flags])
    has_many(:feature_flag_usages, through: [:environments, :feature_flags, :feature_flag_usages])
    has_many(:environment_tokens, through: [:environments, :environment_tokens])
    has_many(:users_organizations, Fleature.Schemas.UsersOrganization)
    many_to_many(:users, Fleature.Schemas.User, join_through: "users_organizations")
  end

  def insert_changeset(organization, user, attrs \\ %{}) do
    organization
    |> Repo.preload(:users)
    |> cast(attrs, [:name])
    |> put_assoc(:users, [user])
    |> validate_required([:name])
  end

  def update_changeset(organization, attrs \\ %{}) do
    organization
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
