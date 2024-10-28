defmodule PoliciesLive.Repo do
  use Ecto.Repo,
    otp_app: :policies_live,
    adapter: Ecto.Adapters.Postgres
end
