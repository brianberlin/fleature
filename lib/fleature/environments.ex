defmodule Fleature.Environments do
  @moduledoc false
  import Ecto.Query

  alias Ecto.Multi
  alias Fleature.Repo
  alias Fleature.Schemas.Environment

  def insert_environment(attrs) do
    %Environment{}
    |> Environment.insert_changeset(attrs)
    |> Repo.insert()
  end

  def delete_environment(environment) do
    environment =
      Repo.preload(environment, [:feature_flags, :feature_flag_usages, :environment_tokens])

    Multi.new()
    |> Repo.delete_all_multi(environment.environment_tokens)
    |> Repo.delete_all_multi(environment.feature_flag_usages)
    |> Repo.delete_all_multi(environment.feature_flags)
    |> Multi.delete(:environment, environment)
    |> Repo.transaction()
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
