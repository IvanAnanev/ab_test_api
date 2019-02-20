defmodule AbTestApi.Repo.Migrations.CreateOptions do
  use Ecto.Migration

  def change do
    create table(:options) do
      add :value, :string
      add :percentage, :integer
      add :count_cache, :integer
      add :experiment_id, references(:experiments, on_delete: :delete_all)

      timestamps()
    end

    create index(:options, [:experiment_id])
  end
end
