defmodule FleatureWeb.HomeLiveTest do
  use FleatureWeb.ConnCase

  setup :register_and_log_in_user

  describe "Home" do
    test "renders", %{conn: conn, user: user} do
      %{organization: %{name: name1}} = user |> with_organization()
      %{organization: %{name: name2}} = user |> with_organization()

      {:ok, view, html} = live(conn, Routes.home_path(conn, :index))
      assert html =~ "Welcome to Fleature"
      assert html =~ "Organizations"
      assert html =~ name1
      assert html =~ name2
      assert html =~ "Create Organization"

      view
      |> element(".create-organization")
      |> render_click()

      assert_patched(
        view,
        Routes.organizations_path(FleatureWeb.Endpoint, :create)
      )
    end
  end
end
