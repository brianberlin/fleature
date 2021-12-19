defmodule Fleature.Organizations do
  @moduledoc false
  import Ecto.Query

  alias Ecto.Multi
  alias Fleature.Repo
  alias Fleature.Schemas.Organization
  alias Fleature.Schemas.UsersOrganization

  def insert_organization(user, attrs) do
    %Organization{}
    |> Organization.insert_changeset(user, attrs)
    |> Repo.insert()
  end

  def delete_organization(organization) do
    preloads = [:projects, :environments, :environment_tokens, :feature_flags, :users_organizations]
    organization = Repo.preload(organization, preloads)

    Multi.new()
    |> delete_all(organization.feature_flags)
    |> delete_all(organization.environment_tokens)
    |> delete_all(organization.environments)
    |> delete_all(organization.projects)
    |> delete_all(organization.users_organizations)
    |> Multi.delete(:organization, organization)
    |> Repo.transaction()
  end

  def query_organizations(params) do
    apply_filters(Organization, params)
  end

  def get_organization(params \\ []) do
    params
    |> query_organizations()
    |> Repo.one()
  end

  def list_organizations(params \\ []) when is_list(params) do
    params
    |> query_organizations()
    |> default_order()
    |> Repo.all()
  end

  defp filter(query, {:id, id}) do
    where(query, id: ^id)
  end

  defp filter(query, {:user_id, user_id}) do
    query
    |> join(:left, [o], uo in UsersOrganization, on: o.id == uo.organization_id, as: :uo)
    |> where([uo: uo], uo.user_id == ^user_id)
  end

  defp apply_filters(query, params) do
    Enum.reduce(params, query, fn param, query ->
      filter(query, param)
    end)
  end

  defp default_order(query) do
    order_by(query, [s], asc: s.name)
  end

  defp delete_all(multi, items) do
    items
    |> Enum.with_index()
    |> Enum.reduce(multi, fn {item, index}, multi ->
      Multi.delete(multi, :"#{item.__meta__.source}_#{index}", item)
    end)
  end
end
