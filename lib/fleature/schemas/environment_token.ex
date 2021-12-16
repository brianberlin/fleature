defmodule Fleature.Schemas.EnvironmentToken do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "environment_tokens" do
    field(:client_id, :binary)
    field(:hashed_client_secret, :binary)
    belongs_to(:environment, Fleature.Schemas.Environment)
    belongs_to(:user, Fleature.Schemas.User)
  end

  def insert_changeset(environment_token, attrs \\ %{}) do
    environment_token
    |> cast(attrs, [:client_id, :hashed_client_secret, :environment_id, :user_id])
    |> validate_required([:client_id, :hashed_client_secret, :environment_id, :user_id])
  end
end
