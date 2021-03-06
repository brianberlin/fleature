defmodule Fleature.Factory do
  use ExMachina.Ecto, repo: Fleature.Repo
  use Fleature.OrganizationFactory
  use Fleature.UserFactory
  use Fleature.ProjectFactory
  use Fleature.EnvironmentFactory
  use Fleature.FeatureFlagFactory
  use Fleature.FeatureFlagUsageFactory
  use Fleature.EnvironmentTokenFactory
end
