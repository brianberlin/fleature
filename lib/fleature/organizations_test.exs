defmodule Fleature.OrganizationsTest do
  use Fleature.DataCase

  import Fleature.Organizations

  test "list_organizations" do
    %{organization: %{id: id1}} = insert(:user) |> with_organization()
    %{organization: %{id: id2}} = insert(:user) |> with_organization()
    [%{id: ^id1}, %{id: ^id2}] = list_organizations([])
  end
end
