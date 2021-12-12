defmodule FleatureWeb.Projects.CreateTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "create project", %{conn: conn} do
    organization = insert(:organization)
    {:ok, view, html} = live(conn, Routes.projects_path(conn, :create, organization))

    assert html =~ "Create a Project"
    assert html =~ "Name"

    view
    |> element("form")
    |> render_submit(%{project: %{name: "Test", organization_id: organization.id}})

    # [project] = Fleature.Projects.list_projects([])

    # assert_patched(view, Routes.projects_path(FleatureWeb.Endpoint, :view, project))
  end
end
