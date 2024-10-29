defmodule PoliciesLiveWeb.Forms.SortingForm do
  import Ecto.Changeset
  alias PoliciesLive.EctoHelper

  @fields %{
    sort_by: EctoHelper.enum([:policy_number, :insured_first_name, :insured_last_name]),
    sort_dir: EctoHelper.enum([:asc, :desc])
  }

  @default_values %{
    sort_by: :insured_first_name,
    sort_dir: :asc
  }

  def parse(params) do
    {@default_values, @fields}
    |> cast(params, Map.keys(@fields))
    |> apply_action(:insert)
  end

  def default_values(), do: @default_values
end
