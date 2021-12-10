defmodule FleatureWeb.Plugs.DefaultPageTitleTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "creates title based on path", %{conn: conn} do
    assert_title conn, "Users Register - Fleature", "/users/register"
    assert_title conn, "Fleature", "/"
  end

  defp assert_title(conn, title, path) do
    assert %{assigns: %{page_title: page_title}} = get(conn, path)
    assert page_title == title
  end
end
