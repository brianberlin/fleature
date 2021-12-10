defmodule Fleature.Schemas.OrganizationTest do
  use Fleature.DataCase, async: true

  alias Fleature.Schemas.Organization

  test "insert_changeset" do
    user = insert(:user)

    assert %Ecto.Changeset{valid?: true, changes: %{name: "Test"}} =
             Organization.insert_changeset(%Organization{}, user, %{name: "Test"})
  end
end
