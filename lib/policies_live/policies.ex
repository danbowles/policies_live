defmodule PoliciesLive.Policies do
  @moduledoc """
  Policies jcontext
  """
  import Ecto.Query, warn: false

  alias PoliciesLive.Policies.Policy
  alias PoliciesLive.Repo

  def list_policies(opts) do
    from(p in Policy)
    |> filter(opts)
    |> sort(opts)
    |> Repo.all()
  end

  def policy_count(), do: Repo.aggregate(Policy, :count)

  def list_policies_with_pagination(offset, limit) do
    from(p in Policy)
    |> limit(^limit)
    |> offset(^offset)
    |> Repo.all()
  end

  def list_policies_with_count(opts) do
    q = from(p in Policy) |> filter(opts)
    count = Repo.aggregate(q, :count)

    policies = q |> sort(opts) |> paginate(opts) |> Repo.all()

    %{policies: policies, count: count}
  end

  defp filter(query, opts) do
    query
    |> filter_by_policy_number(opts)
    |> filter_by_first_name(opts)
    |> filter_by_last_name(opts)
  end

  defp paginate(query, %{page: page, page_size: page_size})
       when page > 0 and page_size > 0 do
    # Course correct in case we accidentally get a negative page
    offset = max(0, page - 1) * page_size
    query |> limit(^page_size) |> offset(^offset)
  end

  defp paginate(query, _opts), do: query

  defp filter_by_policy_number(query, %{policy_number: policy_number})
       when policy_number !== nil do
    query |> where(policy_number: ^policy_number)
  end

  defp filter_by_policy_number(query, _opts), do: query

  defp filter_by_first_name(query, %{insured_first_name: insured_first_name})
       when is_binary(insured_first_name) and insured_first_name !== nil do
    query_string = "#{insured_first_name}%"
    query |> where([p], ilike(p.insured_first_name, ^query_string))
  end

  defp filter_by_first_name(query, _opts), do: query

  defp filter_by_last_name(query, %{insured_last_name: insured_last_name})
       when is_binary(insured_last_name) and insured_last_name !== nil do
    query_string = "#{insured_last_name}%"
    query |> where([p], ilike(p.insured_last_name, ^query_string))
  end

  defp filter_by_last_name(query, _opts), do: query

  defp sort(query, %{sort_by: sort_by, sort_dir: sort_dir})
       when sort_by in [:insured_first_name, :insured_last_name, :policy_number] and
              sort_dir in [
                :asc,
                :desc
              ] do
    order_by(query, {^sort_dir, ^sort_by})
  end

  defp sort(query, _opts) do
    query
  end
end
