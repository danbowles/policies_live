defmodule PoliciesLive.Repo.Migrations.CreatePolicies do
  use Ecto.Migration

  def change do
    create table(:policies) do
      add :policy_number, :string
      add :insured_first_name, :string
      add :insured_last_name, :string
      add :insured_age, :integer
      add :insured_email, :string
      add :vehicle_make, :string
      add :vehicle_model, :string
      add :vehicle_year, :integer
      add :vehicle_vin, :string
      add :policy_start_date, :utc_datetime
      add :street_address, :string
      add :city, :string
      add :state, :string
      add :postal_code, :string
      add :latitude, :float
      add :longitude, :float
      add :country, :string

      timestamps()
    end
  end
end
