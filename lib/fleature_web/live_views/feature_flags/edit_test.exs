defmodule FleatureWeb.FeatureFlags.EditTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "edit feature_flag", %{conn: conn} do
    feature_flag = insert(:feature_flag)
    {:ok, view, html} = live(conn, Routes.feature_flags_path(conn, :edit, feature_flag))

    assert html =~ feature_flag.name

    new_name = feature_flag.name <> " (edited)"

    view
    |> element("form")
    |> render_submit(%{feature_flag: %{name: ""}})

    assert render(view) =~ "can&#39;t be blank"

    view
    |> element("form")
    |> render_submit(%{feature_flag: %{name: new_name}})

    assert [feature_flag] = Fleature.FeatureFlags.list_feature_flags([])
    assert feature_flag.name == new_name

    # assert_redirect(view, Routes.home_path(FleatureWeb.Endpoint, :index))
  end
end
