# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PoliciesLive.Repo.insert!(%PoliciesLive.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

json_file_path = "#{__DIR__}/seed_policies.json"

with {:ok, body} <- File.read(json_file_path),
     {:ok, json} <- Jason.decode(body, keys: :atoms) do
  IO.puts("Seeding policies...")

  for policy <- json do
    {:ok, utc_datetime, _} = DateTime.from_iso8601(policy.policy_start_date)

    PoliciesLive.Repo.insert!(%PoliciesLive.Policies.Policy{
      policy_number: policy.policy_number,
      insured_first_name: policy.insured_first_name,
      insured_last_name: policy.insured_last_name,
      insured_age: policy.insured_age,
      insured_email: policy.insured_email,
      vehicle_make: policy.vehicle_make,
      vehicle_model: policy.vehicle_model,
      vehicle_year: policy.vehicle_year,
      vehicle_vin: policy.vehicle_vin,
      policy_start_date: utc_datetime,
      street_address: policy.street_address,
      city: policy.city,
      state: policy.state,
      postal_code: policy.postal_code,
      latitude: policy.latitude,
      longitude: policy.longitude,
      country: policy.country,
      inserted_at: DateTime.utc_now() |> DateTime.truncate(:second),
      updated_at: DateTime.utc_now() |> DateTime.truncate(:second)
    })
  end
else
  {:error, reason} -> IO.inspect(reason)
end
