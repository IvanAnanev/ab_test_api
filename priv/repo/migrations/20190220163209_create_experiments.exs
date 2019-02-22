defmodule AbTestApi.Repo.Migrations.CreateExperiments do
  use Ecto.Migration

  def change do
    create table(:experiments) do
      add :key, :string
      add :devices_count, :integer, default: 0, null: false

      timestamps()
    end

  end
end
