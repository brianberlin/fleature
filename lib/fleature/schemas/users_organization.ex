defmodule Fleature.Schemas.UsersOrganization do
  use Ecto.Schema

  alias Fleature.Schemas.Organization
  alias Fleature.Schemas.User

  schema "users_organizations" do
    belongs_to(:organization, Organization)
    belongs_to(:user, User)
  end
end
