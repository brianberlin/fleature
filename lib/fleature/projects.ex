defmodule Fleature.Projects do
  import Ecto.Query

  alias Fleature.Schemas.Project
  alias Fleature.Repo

  def insert_project(attrs) do
    %Project{}
    |> Project.insert_changeset(attrs)
    |> Repo.insert()
  end

  def query_projects(params) do
    apply_filters(Project, params)
  end

  def get_project(params \\ [], preloads \\ []) do
    params
    |> query_projects()
    |> preload(^preloads)
    |> Repo.one()
  end

  def list_projects(params \\ []) when is_list(params) do
    params
    |> query_projects()
    |> default_order()
    |> Repo.all()
  end

  defp filter(query, {:id, id}) do
    where(query, id: ^id)
  end

  defp filter(query, {:organization_id, id}) do
    where(query, organization_id: ^id)
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
