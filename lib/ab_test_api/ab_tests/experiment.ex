defmodule AbTestApi.ABTests.Experiment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "experiments" do
    field :count_cache, :integer
    field :key, :string

    timestamps()
  end

  @doc false
  def changeset(experiment, attrs) do
    experiment
    |> cast(attrs, [:key, :count_cache])
    |> validate_required([:key, :count_cache])
  end
end
