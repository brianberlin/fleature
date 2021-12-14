defmodule Fleature.EnvironmentTokens do
  alias Fleature.Schemas.EnvironmentToken
  alias Fleature.Repo

  import Ecto.Query

  def insert_environment_token(attrs) do
    %EnvironmentToken{}
    |> EnvironmentToken.insert_changeset(attrs)
    |> Repo.insert()
  end

  def delete_environment_token(environment_token) do
    Repo.delete(environment_token)
  end

  def query_environment_tokens(params) do
    apply_filters(EnvironmentToken, params)
  end

  def get_environment_token(params \\ [], preloads \\ []) do
    params
    |> query_environment_tokens()
    |> preload(^preloads)
    |> Repo.one()
  end

  def list_environment_tokens(params \\ []) when is_list(params) do
    params
    |> query_environment_tokens()
    |> default_order()
    |> Repo.all()
  end

  defp filter(query, {:id, id}) do
    where(query, id: ^id)
  end

  defp filter(query, {:environment_id, id}) do
    where(query, environment_id: ^id)
  end

  defp apply_filters(query, params) do
    Enum.reduce(params, query, fn param, query ->
      filter(query, param)
    end)
  end

  defp default_order(query) do
    order_by(query, [s], asc: s.id)
  end
end
