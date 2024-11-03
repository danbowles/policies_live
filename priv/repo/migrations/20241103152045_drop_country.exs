defmodule PoliciesLive.Repo.Migrations.DropCountry do
  use Ecto.Migration

  def change do
    alter table(:policies) do
      remove :country
    end
  end
end
