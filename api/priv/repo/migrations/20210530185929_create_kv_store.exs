defmodule SecretsApi.Repo.Migrations.CreateKvStore do
  use Ecto.Migration

  def change do
    create table(:analytics_key_value) do
      add :key, :string
      add :value, :string

      timestamps()
    end

    create unique_index(:analytics_key_value, [:key])
  end
end
