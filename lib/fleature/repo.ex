defmodule Fleature.Repo do
  use Ecto.Repo,
    otp_app: :fleature,
    adapter: Ecto.Adapters.Postgres
end
