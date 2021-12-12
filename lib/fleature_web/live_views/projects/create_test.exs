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
    |> render_change(%{project: %{name: "Test", organization_id: organization.id}})

    html =
      view
      |> element("form")
      |> render_submit(%{project: %{name: "", organization_id: organization.id}})

    assert html =~ "can&#39;t be blank"

    view
    |> element("form")
    |> render_submit(%{project: %{name: "Test2", organization_id: organization.id}})

    [project] = Fleature.Projects.list_projects([])

    assert_patch(view, Routes.projects_path(FleatureWeb.Endpoint, :view, organization, project))
  end
end
