defmodule FleatureWeb.Organizations.ViewTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "view organization", %{conn: conn, user: user} do
    %{organization: organization} = with_organization(user)
    insert(:project, organization: organization)
    {:ok, view, html} = live(conn, Routes.organizations_path(conn, :view, organization))
    assert html =~ organization.name

    view
    |> element(".create-project")
    |> render_click()

    assert_patched(view, Routes.projects_path(FleatureWeb.Endpoint, :create, organization))
  end
end
