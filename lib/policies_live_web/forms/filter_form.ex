defmodule PoliciesLiveWeb.Forms.FilterForm do
  import Ecto.Changeset

  @fields %{
    policy_number: :string,
    insured_first_name: :string,
    insured_last_name: :string
  }

  @default_values %{
    policy_number: nil,
    insured_first_name: nil,
    insured_last_name: nil
  }

  def default_values(overrides \\ %{}), do: Map.merge(@default_values, overrides)

  def parse(params) do
    {default_values(), @fields}
    |> cast(params, Map.keys(@fields))
    |> apply_action(:insert)
  end

  def change_values(values \\ @default_values) do
    {values, @fields}
    |> cast(%{}, Map.keys(@fields))
  end
end
