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
    |> cast(attrs, [:value, :percentage, :count_cache])
    |> validate_required([:value, :percentage, :count_cache])
  end
end
