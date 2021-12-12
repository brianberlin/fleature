defmodule Fleature.Repo.Migrations.FeatureFlagStatus do
  use Ecto.Migration

  def change do
    alter(table(:feature_flags)) do
      add(:status, :boolean)
    end
  end
end
