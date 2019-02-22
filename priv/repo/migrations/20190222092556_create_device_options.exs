defmodule AbTestApi.Repo.Migrations.CreateDeviceOptions do
  use Ecto.Migration

  def change do
    create table(:device_options) do
      add :device_id, references(:devices, on_delete: :delete_all)
      add :option_id, references(:options, on_delete: :delete_all)

      timestamps()
    end

    create index(:device_options, [:device_id])
    create index(:device_options, [:option_id])
  end
end
