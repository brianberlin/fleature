defmodule FleatureWeb.AppLiveTest do
  use FleatureWeb.ConnCase

  describe "Home" do
    test "renders", %{conn: conn} do
      {:ok, _view, html} = live(conn, Routes.home_path(conn, :index))
      assert html =~ "Fleature"
    end
  end
end
