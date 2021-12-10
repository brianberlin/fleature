defmodule FleatureWeb.OrganizationsLiveTest do
  use FleatureWeb.ConnCase, async: true

  setup :register_and_log_in_user

  test "organizations", %{conn: _conn} do
    assert true
  end
end
