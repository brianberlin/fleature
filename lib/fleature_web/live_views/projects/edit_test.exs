defmodule FleatureWeb.Projects.EditTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "edit project", %{conn: conn} do
    project = insert(:project)
    {:ok, view, html} = live(conn, Routes.projects_path(conn, :edit, project))

    assert html =~ project.name

    new_name = project.name <> " (edited)"

    view
    |> element("form")
    |> render_submit(%{project: %{name: ""}})

    assert render(view) =~ "can&#39;t be blank"

    view
    |> element("form")
    |> render_submit(%{project: %{name: new_name}})

    assert [project] = Fleature.Projects.list_projects([])
    assert project.name == new_name

    # assert_redirect(view, Routes.home_path(FleatureWeb.Endpoint, :index))
  end
end
