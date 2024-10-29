defmodule PoliciesLive.Policies do
  @moduledoc """
  Policies jcontext
  """
  import Ecto.Query, warn: false

  alias PoliciesLive.Policies.Policy
  alias PoliciesLive.Repo

  def list_policies(opts) do
    from(p in Policy)
    |> sort(opts)
    |> Repo.all()
  end

  defp sort(query, %{sort_by: sort_by, sort_dir: sort_dir})
       when sort_by in [:insured_first_name, :insured_last_name, :policy_number] and
              sort_dir in [
                :asc,
                # :asc_nulls_first,
                # :asc_nulls_last,
                :desc
                # :desc_nulls_first,
                # :desc_nulls_last
              ] do
    order_by(query, {^sort_by, ^sort_dir})
  end

  defp sort(query, _opts) do
    query
  end
end
