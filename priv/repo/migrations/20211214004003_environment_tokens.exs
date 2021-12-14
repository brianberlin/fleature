defmodule Fleature.Repo.Migrations.EnvironmentTokens do
  use Ecto.Migration

  def change do
    create(table(:environment_tokens)) do
      add(:environment_id, references(:environments))
      add(:user_id, references(:users))
      add(:client_id, :binary)
      add(:hashed_client_secret, :binary)
    end
  end
end
