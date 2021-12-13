defmodule FleatureWeb.FeatureFlagsLive.CreateTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "create feature_flag", %{conn: conn} do
    environment = insert(:environment)

    {:ok, view, html} = live(conn, Routes.feature_flags_path(conn, :create, environment))

    assert html =~ "Create a Feature Flag"
    assert html =~ "Name"

    view
    |> element("form")
    |> render_change(%{feature_flag: %{name: "Test", environment_id: environment.id}})

    view
    |> element("form")
    |> render_submit(%{feature_flag: %{name: "Test2", environment_id: environment.id}})

    assert [_feature_flag] = Fleature.FeatureFlags.list_feature_flags([])
  end
end
