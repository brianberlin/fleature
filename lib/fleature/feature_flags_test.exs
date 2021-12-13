defmodule Fleature.FeatureFlagsTest do
  use Fleature.DataCase, async: true

  import Fleature.FeatureFlags

  test "list_feature_flags" do
    insert(:feature_flag)
    assert [_] = list_feature_flags([])
  end

  test "get_feature_flag" do
    %{id: id} = insert(:feature_flag)
    assert %{id: ^id} = get_feature_flag(id: id)
  end
end
