defmodule Fleature.OrganizationsTest do
  use Fleature.DataCase

  import Fleature.Organizations

  describe "list_organizations" do
    test "default" do
      %{organization: %{id: id1}} = insert(:user) |> with_organization(%{name: "a"})
      %{organization: %{id: id2}} = insert(:user) |> with_organization(%{name: "b"})
      [%{id: ^id1}, %{id: ^id2}] = list_organizations([])
    end

    test "for user" do
      %{user: user, organization: %{id: id1}} = insert(:user) |> with_organization()
      insert(:user) |> with_organization()
      [%{id: ^id1}] = list_organizations(user_id: user.id)
    end
  end

  test "insert_organization" do
    user = insert(:user)
    assert {:ok, _organization} = insert_organization(user, %{name: "Test"})
    assert {:error, _changeset} = insert_organization(user, %{name: ""})
    assert {:error, _changeset} = insert_organization(nil, %{name: "Test"})
  end

  test "delete_organization" do
    feature_flag = insert(:feature_flag)
    organization = feature_flag.environment.project.organization
    insert(:users_organization, user: insert(:user), organization: organization)
    assert {:ok, _} = delete_organization(organization)
    assert [] = Repo.all(Fleature.Schemas.Environment)
    assert [] = Repo.all(Fleature.Schemas.FeatureFlag)
    assert [] = Repo.all(Fleature.Schemas.Organization)
    assert [] = Repo.all(Fleature.Schemas.EnvironmentToken)
    assert [] = Repo.all(Fleature.Schemas.UsersOrganization)
  end
end
