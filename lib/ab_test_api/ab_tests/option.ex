defmodule AbTestApi.ABTests.Option do
  use Ecto.Schema
  import Ecto.Changeset
  alias AbTestApi.ABTests.{ Experiment, DeviceOption }


  schema "options" do
    field :devices_count, :integer
    field :percentage, :integer
    field :value, :string
    # field :experiment_id, :id
    belongs_to :experiment, Experiment
    has_many :device_options, DeviceOption
    has_many :devices, through: [:device_options, :device]

    timestamps()
  end

  @doc false
  def changeset(option, attrs) do
    option
    |> cast(attrs, [:value, :percentage])
    |> validate_required([:value, :percentage])
    |> validate_inclusion(:percentage, 1..99)
  end

  @doc false
  def devices_count_changeset(experiment, attrs) do
    experiment
    |> cast(attrs, [:devices_count])
    |> validate_required([:devices_count])
  end
end
