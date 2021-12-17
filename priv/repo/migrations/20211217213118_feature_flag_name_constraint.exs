defmodule Fleature.Repo.Migrations.FeatureFlagNameConstraint do
  use Ecto.Migration

  def change do
    create(index(:feature_flags, [:name, :environment_id], unique: true))
  end
end
