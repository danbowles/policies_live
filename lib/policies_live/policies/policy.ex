defmodule PoliciesLive.Policies.Policy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "policies" do
    field :policy_number, :string
    field :insured_first_name, :string
    field :insured_last_name, :string
    field :insured_age, :integer
    field :insured_email, :string
    field :vehicle_make, :string
    field :vehicle_model, :string
    field :vehicle_year, :integer
    field :vehicle_vin, :string
    field :policy_start_date, :utc_datetime
    field :street_address, :string
    field :city, :string
    field :state, :string
    field :postal_code, :string
    field :balance, :integer
    field :status, Ecto.Enum, values: [:active, :suspended, :cancelled, :terminated]
    field :inserted_at, :utc_datetime
    field :updated_at, :utc_datetime
  end

  def changeset(policy, attrs) do
    policy_atoms = [
      :policy_number,
      :insured_first_name,
      :insured_last_name,
      :insured_age,
      :insured_email,
      :vehicle_make,
      :vehicle_model,
      :vehicle_year,
      :vehicle_vin,
      :policy_start_date,
      :street_address,
      :city,
      :state,
      :postal_code,
      :balance,
      :status
    ]

    policy
    |> cast(attrs, policy_atoms)
    |> validate_required(policy_atoms)
  end
end
