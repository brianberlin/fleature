defmodule FleatureWeb.Projects.ViewTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "view organization", %{conn: conn, user: user} do
    %{organization: organization} = with_organization(user)
    project = insert(:project, organization: organization)
    {:ok, _view, html} = live(conn, Routes.projects_path(conn, :view, project))
    assert html =~ project.name
  end
end
