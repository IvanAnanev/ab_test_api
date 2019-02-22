defmodule AbTestApi.Repo.Migrations.CreateOptions do
  use Ecto.Migration

  def change do
    create table(:options) do
      add :value, :string
      add :percentage, :integer, null: false
      add :devices_count, :integer, default: 0, null: false
      add :experiment_id, references(:experiments, on_delete: :delete_all)

      timestamps()
    end

    create index(:options, [:experiment_id])
  end
end
