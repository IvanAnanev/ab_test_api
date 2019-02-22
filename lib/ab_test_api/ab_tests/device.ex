defmodule AbTestApi.ABTests.Device do
  use Ecto.Schema
  import Ecto.Changeset
  alias AbTestApi.ABTests.DeviceOption

  schema "devices" do
    field :token, :string

    has_many :device_options, DeviceOption
    has_many :options, through: [:device_options, :option]
    has_many :expirements, through: [:options, :expirement]

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:token])
    |> validate_required([:token])
    |> unique_constraint(:token)
  end
end
