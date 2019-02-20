defmodule AbTestApi.Repo.Migrations.CreateExperiments do
  use Ecto.Migration

  def change do
    create table(:experiments) do
      add :key, :string
      add :count_cache, :integer

      timestamps()
    end

  end
end
