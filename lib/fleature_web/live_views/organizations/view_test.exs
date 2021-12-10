defmodule FleatureWeb.Organizations.ViewTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "create organization", %{conn: conn, user: user} do
    %{organization: organization} = with_organization(user)
    {:ok, _view, html} = live(conn, Routes.organizations_path(conn, :view, organization))
    assert html =~ organization.name
  end
end
