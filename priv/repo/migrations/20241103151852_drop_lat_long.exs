defmodule PoliciesLive.Repo.Migrations.DropLatLong do
  use Ecto.Migration

  def change do
    alter table(:policies) do
      remove :latitude
      remove :longitude
    end
  end
end
