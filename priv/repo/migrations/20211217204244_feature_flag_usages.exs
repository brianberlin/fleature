defmodule Fleature.Repo.Migrations.FeatureFlagUsages do
  use Ecto.Migration

  def change do
    create(table(:feature_flag_usages)) do
      add(:count, :integer)
      add(:environment_id, references(:environments))
      add(:feature_flag_id, references(:feature_flags))
      add(:recorded_at, :naive_datetime)
    end
  end
end
