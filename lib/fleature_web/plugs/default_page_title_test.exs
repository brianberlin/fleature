defmodule FleatureWeb.Plugs.DefaultPageTitleTest do
  use FleatureWeb.ConnCase, async: true

  def assert_title(conn, title, path) do
    assert %{assigns: %{page_title: page_title}} = get(conn, path)
    assert page_title == title
  end

  test "creates title based on path", %{conn: conn} do
    assert_title conn, "Users Register - Fleature", "/users/register"
    assert_title conn, "Fleature", "/"
  end
end
