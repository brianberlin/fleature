defmodule Fleature.ProjectsTest do
  use Fleature.DataCase, async: true

  import Fleature.Projects

  test "list_projects" do
    insert(:project)
    assert [_] = list_projects([])
  end

  test "get_project" do
    %{id: id} = insert(:project)
    assert %{id: ^id} = get_project(id: id)
  end

  test "insert_project" do
    organization = insert(:organization)
    attrs = %{name: "", organization_id: organization.id}
    assert {:error, %{errors: [name: _]}} = insert_project(attrs)

    attrs = %{name: "Test"}
    assert {:error, %{errors: [organization_id: _]}} = insert_project(attrs)

    attrs = %{name: "Test", organization_id: organization.id}
    assert {:ok, _} = insert_project(attrs)
  end
end
