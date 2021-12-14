defmodule FleatureWeb.EnvironmentsLive.ViewTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "view environment", %{conn: conn} do
    environment = insert(:environment)

    {:ok, _view, html} = live(conn, Routes.environments_path(conn, :view, environment))

    assert html =~ environment.name
  end

  test "can create environment token", %{conn: conn} do
    environment = insert(:environment)
    {:ok, view, _html} = live(conn, Routes.environments_path(conn, :view, environment))

    view
    |> element(".create_environment_token")
    |> render_click()
  end
end
