defmodule AbTestApi.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :token, :string

      timestamps()
    end

    create unique_index(:devices, [:token])
  end
end
