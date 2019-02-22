defmodule AbTestApi.ABTests.Experiment do
  use Ecto.Schema
  import Ecto.Changeset
  alias AbTestApi.ABTests.Option
  require Integer

  schema "experiments" do
    field :devices_count, :integer
    field :key, :string

    has_many :options, Option
    has_many :devices, through: [:options, :devices]

    timestamps()
  end

  @doc false
  def changeset(experiment, attrs) do
    experiment
    |> cast(attrs, [:key])
    |> validate_required([:key])
    |> cast_assoc(:options, required: true)
    |> validate_options_percentage()
  end

  defp validate_options_percentage(%{errors: []} = changeset) do
    options = get_field(changeset, :options)
    if percentage_sum_valid?(options) do
      changeset
    else
      add_error(changeset, :base, "Not valid percentage sum for options")
    end
  end
  defp validate_options_percentage(changeset), do: changeset

  @even_sum 100
  defp percentage_sum_valid?(options) when Integer.is_even(length(options)) do
    Enum.reduce(options, 0, fn(x, acc) -> x.percentage + acc end) == @even_sum
  end
  @odd_sum 99
  defp percentage_sum_valid?(options) do
    Enum.reduce(options, 0, fn(x, acc) -> x.percentage + acc end) == @odd_sum
  end

  @doc false
  def devices_count_changeset(experiment, attrs) do
    experiment
    |> cast(attrs, [:devices_count])
    |> validate_required([:devices_count])
  end
end
