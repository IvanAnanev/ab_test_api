defmodule AbTestApi.ABTests.DeviceOption do
  use Ecto.Schema
  import Ecto.Changeset
  alias AbTestApi.ABTests.{ Device, Option }


  schema "device_options" do
    # field :device_id, :id
    # field :option_id, :id
    belongs_to :device, Device
    belongs_to :option, Option

    timestamps()
  end

  @doc false
  def changeset(device_option, attrs) do
    device_option
    |> cast(attrs, [])
    |> validate_required([])
  end
end
