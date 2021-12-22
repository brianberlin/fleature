defmodule FleatureWeb.EnvironmentsLive.CreateTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "create environment", %{conn: conn} do
    project = insert(:project)
    organization = project.organization

    {:ok, view, html} = live(conn, Routes.environments_path(conn, :create, project))

    assert html =~ "Create an Environment"
    assert html =~ "Name"

    view
    |> element("form")
    |> render_change(%{environment: %{name: "Test", organization_id: organization.id}})

    view
    |> element("form")
    |> render_submit(%{environment: %{name: "Test2", organization_id: organization.id}})

    assert [_environment] = Fleature.Environments.list_environments([])

    assert_redirect(
      view,
      Routes.projects_path(FleatureWeb.Endpoint, :view, project)
    )
  end
end
