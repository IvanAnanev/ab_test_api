defmodule AbTestApi.Distributor do
  use GenServer
  alias AbTestApi.ABTests

  ## init
  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  def init(_), do: {:ok, []}

  ## API
  def call(expirement, device), do: GenServer.call(__MODULE__, {:distribute, expirement, device})

  ## Callbacks

  def handle_call({:distribute, %{options: options} = expirement, device}, _from, state) do
    {distributed_option, _x} = options
      |> Enum.map(fn(option) -> {option, calc_var(option, expirement)} end)
      |> Enum.min_by(fn {_, x} -> x end)

    ABTests.create_device_option(device, distributed_option)
    ABTests.cache_devices_count(expirement)
    ABTests.cache_devices_count(distributed_option)

    {:reply, distributed_option, state}
  end

  defp calc_var(%{devices_count: option_count, percentage: percentage} = _option, %{devices_count: expirement_count} = _expirement) do
    (option_count + 1) / (expirement_count + 1) - (percentage / 100)
  end
end
