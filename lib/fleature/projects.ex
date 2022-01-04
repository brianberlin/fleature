defmodule Fleature.Projects do
  @moduledoc false
  import Ecto.Query

  alias Ecto.Multi
  alias Fleature.Repo
  alias Fleature.Schemas.Project

  def insert_project(attrs) do
    %Project{}
    |> Project.insert_changeset(attrs)
    |> Repo.insert()
  end

  def update_project(project, attrs) do
    project
    |> Project.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_project(project) do
    preloads = [:environments, :feature_flags, :feature_flag_usages, :environment_tokens]
    project = Repo.preload(project, preloads)

    Multi.new()
    |> Repo.delete_all_multi(project.feature_flag_usages)
    |> Repo.delete_all_multi(project.feature_flags)
    |> Repo.delete_all_multi(project.environment_tokens)
    |> Repo.delete_all_multi(project.environments)
    |> Multi.delete(:project, project)
    |> Repo.transaction()
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
