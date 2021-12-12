defmodule Fleature.Environments do
  import Ecto.Query

  alias Fleature.Schemas.Environment
  alias Fleature.Repo

  def insert_environment(attrs) do
    %Environment{}
    |> Environment.insert_changeset(attrs)
    |> Repo.insert()
  end

  def query_environments(params) do
    apply_filters(Environment, params)
  end

  def get_environment(params \\ [], preloads \\ []) do
    params
    |> query_environments()
    |> preload(^preloads)
    |> Repo.one()
  end

  def list_environments(params \\ []) when is_list(params) do
    params
    |> query_environments()
    |> default_order()
    |> Repo.all()
  end

  defp filter(query, {:id, id}) do
    where(query, id: ^id)
  end

  defp filter(query, {:project_id, id}) do
    where(query, project_id: ^id)
  end

  defp apply_filters(query, params) do
    Enum.reduce(params, query, fn param, query ->
      filter(query, param)
    end)
  end

  defp default_order(query) do
    order_by(query, [s], asc: s.name)
  end
end
