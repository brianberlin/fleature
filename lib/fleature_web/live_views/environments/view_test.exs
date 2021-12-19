defmodule FleatureWeb.EnvironmentsLive.ViewTest do
  use FleatureWeb.ConnCase, async: true

  setup %{conn: conn} do
    %{conn: conn} = register_and_log_in_user(%{conn: conn})
    environment = insert(:environment)
    feature_flag = insert(:feature_flag, environment: environment)
    {:ok, view, _html} = live(conn, Routes.environments_path(conn, :view, environment))
    {:ok, view: view, environment: environment, feature_flag: feature_flag}
  end

  test "view environment", %{view: view, environment: environment} do
    assert render(view) =~ environment.name
  end

  test "can create environment token", %{view: view} do
    assert view
           |> element(".create_environment_token")
           |> render_click() =~ "Client Id"
  end

  test "can delete environments", %{view: view, feature_flag: feature_flag} do
    assert render(view) =~ "Delete"

    view
    |> element(".delete_feature_flag_#{feature_flag.id}")
  end
end
