defmodule AbTestApi.ABTests.Option do
  use Ecto.Schema
  import Ecto.Changeset
  alias AbTestApi.ABTests.Experiment


  schema "options" do
    field :count_cache, :integer
    field :percentage, :integer
    field :value, :string
    # field :experiment_id, :id
    belongs_to :experiment, Experiment

    timestamps()
  end

  @doc false
  def changeset(option, attrs) do
    option
    |> cast(attrs, [:value, :percentage])
    |> validate_required([:value, :percentage])
    |> validate_inclusion(:percentage, 1..99)
  end
end
