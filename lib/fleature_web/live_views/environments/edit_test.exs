defmodule FleatureWeb.Environments.EditTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "edit environment", %{conn: conn} do
    environment = insert(:environment)
    {:ok, view, html} = live(conn, Routes.environments_path(conn, :edit, environment))

    assert html =~ environment.name

    new_name = environment.name <> " (edited)"

    view
    |> element("form")
    |> render_submit(%{environment: %{name: ""}})

    assert render(view) =~ "can&#39;t be blank"

    view
    |> element("form")
    |> render_submit(%{environment: %{name: new_name}})

    assert [environment] = Fleature.Environments.list_environments([])
    assert environment.name == new_name

    # assert_redirect(view, Routes.home_path(FleatureWeb.Endpoint, :index))
  end
end
