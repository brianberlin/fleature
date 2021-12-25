defmodule FleatureWeb.Organizations.EditTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "edit organization", %{conn: conn} do
    organization = insert(:organization)
    {:ok, view, html} = live(conn, Routes.organizations_path(conn, :edit, organization))

    assert html =~ organization.name

    new_name = organization.name <> " (edited)"

    view
    |> element("form")
    |> render_submit(%{organization: %{name: ""}})

    assert render(view) =~ "can&#39;t be blank"

    view
    |> element("form")
    |> render_submit(%{organization: %{name: new_name}})

    assert [organization] = Fleature.Organizations.list_organizations([])
    assert organization.name == new_name

    # assert_redirect(view, Routes.home_path(FleatureWeb.Endpoint, :index))
  end
end
