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
    preloads = [
      :projects,
      :environments,
      :environment_tokens,
      :feature_flags,
      :feature_flag_usages,
      :users_organizations
    ]

    organization = Repo.preload(organization, preloads)

    Multi.new()
    |> Repo.delete_all_multi(organization.feature_flag_usages)
    |> Repo.delete_all_multi(organization.feature_flags)
    |> Repo.delete_all_multi(organization.environment_tokens)
    |> Repo.delete_all_multi(organization.environments)
    |> Repo.delete_all_multi(organization.projects)
    |> Repo.delete_all_multi(organization.users_organizations)
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
end
