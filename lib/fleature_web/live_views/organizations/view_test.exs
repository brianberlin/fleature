defmodule FleatureWeb.Organizations.ViewTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "view organization", %{conn: conn, user: user} do
    %{organization: organization} = with_organization(user)
    insert(:project, organization: organization)
    {:ok, view, html} = live(conn, Routes.organizations_path(conn, :view, organization))
    assert html =~ organization.name

    view
    |> element(".create-project")
    |> render_click()

    assert_patched(view, Routes.projects_path(FleatureWeb.Endpoint, :create, organization))
  end

  test "delete a project", %{conn: conn, user: user} do
    %{organization: organization} = with_organization(user)
    project = insert(:project, organization: organization)
    {:ok, view, _html} = live(conn, Routes.organizations_path(conn, :view, organization))

    view
    |> element(".delete_project_#{project.id}")
    |> render_click()

    refute render(view) =~ project.name
  end
end
