defmodule FleatureWeb.Organizations.CreateTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "create organization", %{conn: conn} do
    {:ok, view, html} = live(conn, Routes.organizations_path(conn, :create))

    assert html =~ "Create an Organization"
    assert html =~ "Name"

    view
    |> element("form")
    |> render_change(%{organization: %{name: "Test"}})

    view
    |> element("form")
    |> render_submit(%{organization: %{name: ""}})

    view
    |> element("form")
    |> render_submit(%{organization: %{name: "Test"}})

    assert [_organization] = Fleature.Organizations.list_organizations([])

    assert_redirect(view, Routes.home_path(FleatureWeb.Endpoint, :index))
  end
end
