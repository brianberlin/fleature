defmodule FleatureWeb.LiveViews.HomeTest do
  use FleatureWeb.ConnCase

  describe "Home" do
    test "renders", %{conn: conn} do
      {:ok, _view, html} = live(conn, Routes.live_path(conn, FleatureWeb.LiveViews.Home))
      assert html =~ "Welcome to Fleature"
    end
  end
end
