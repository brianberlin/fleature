defmodule FleatureWeb.EnvironmentsLive.ViewTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "view environment", %{conn: conn, user: user} do
    environment = insert(:environment)

    {:ok, _view, html} =
      live(
        conn,
        Routes.environments_path(
          conn,
          :view,
          environment.project.organization,
          environment.project,
          environment
        )
      )

    assert html =~ environment.name
  end
end
