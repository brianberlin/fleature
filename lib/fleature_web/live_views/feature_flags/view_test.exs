defmodule FleatureWeb.FeatureFlagsLive.ViewTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "view feature_flag", %{conn: conn, user: _user} do
    feature_flag = insert(:feature_flag)

    {:ok, _view, html} = live(conn, Routes.feature_flags_path(conn, :view, feature_flag))

    assert html =~ feature_flag.name
  end
end
