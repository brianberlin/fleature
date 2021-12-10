defmodule FleatureWeb.LiveViews.HomeTest do
  use FleatureWeb.ConnCase

  setup :register_and_log_in_user

  describe "Home" do
    test "renders", %{conn: conn, user: user} do
      %{organization: %{name: name1}} = user |> with_organization()
      %{organization: %{name: name2}} = user |> with_organization()

      {:ok, _view, html} = live(conn, Routes.live_path(conn, FleatureWeb.LiveViews.Home))
      assert html =~ "Welcome to Fleature"
      assert html =~ "Organizations"
      assert html =~ name1
      assert html =~ name2
    end
  end
end
