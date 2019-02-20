defmodule AbTestApi.ABTests.Experiment do
  use Ecto.Schema
  import Ecto.Changeset
  alias AbTestApi.ABTests.Option

  schema "experiments" do
    field :count_cache, :integer
    field :key, :string

    has_many :options, Option, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(experiment, attrs) do
    experiment
    |> cast(attrs, [:key, :count_cache])
    |> validate_required([:key, :count_cache])
  end
end
