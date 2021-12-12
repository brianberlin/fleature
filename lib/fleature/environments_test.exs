defmodule Fleature.EnvironmentsTest do
  use Fleature.DataCase, async: true

  import Fleature.Environments

  test "list_environments" do
    insert(:environment)
    assert [_] = list_environments([])
  end

  test "get_environment" do
    %{id: id} = insert(:environment)
    assert %{id: ^id} = get_environment(id: id)
  end
end
