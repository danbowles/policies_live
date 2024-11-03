defmodule PoliciesLive.Repo.Migrations.AddBalanceAndStatus do
  use Ecto.Migration

  @type_name :policy_status

  def change do
    execute(
      """
      CREATE TYPE #{@type_name} AS ENUM ('active', 'suspended', 'cancelled', 'terminated')
      """,
      "DROP TYPE #{@type_name}"
    )

    alter table(:policies) do
      add :balance, :integer
      add :status, :policy_status
    end
  end
end
