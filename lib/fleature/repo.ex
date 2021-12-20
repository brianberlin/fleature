defmodule Fleature.Repo do
  use Ecto.Repo,
    otp_app: :fleature,
    adapter: Ecto.Adapters.Postgres

  alias Ecto.Multi

  def delete_all_multi(multi, []), do: multi

  def delete_all_multi(multi, items) do
    items
    |> Enum.with_index()
    |> Enum.reduce(multi, fn {item, index}, multi ->
      Multi.delete(multi, :"#{item.__meta__.source}_#{index}", item)
    end)
  end
end
