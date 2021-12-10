defmodule Fleature.Organizations do
  import Ecto.Query

  alias Fleature.Schemas.Organization
  alias Fleature.Schemas.UsersOrganization
  alias Fleature.Repo

  def query_organizations(params) do
    apply_filters(Organization, params)
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
