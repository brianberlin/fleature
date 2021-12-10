defmodule Fleature.Repo.Migrations.InitialTables do
  use Ecto.Migration

  def change do
    create(table(:organizations)) do
      add(:name, :string)
    end

    create(table(:users_organizations)) do
      add(:user_id, references(:users))
      add(:organization_id, references(:organizations))
    end

    create(table(:projects)) do
      add(:name, :string)
      add(:organization_id, references(:organizations))
    end

    create(table(:environments)) do
      add(:name, :string)
      add(:project_id, references(:projects))
    end

    create(table(:feature_flags)) do
      add(:name, :string)
      add(:environment_id, references(:environments))
    end
  end
end
