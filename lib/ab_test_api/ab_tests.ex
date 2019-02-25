defmodule AbTestApi.ABTests do
  @moduledoc """
  The ABTests context.
  """

  import Ecto.Query, warn: false
  alias AbTestApi.Repo

  alias AbTestApi.ABTests.{ Experiment, Option, Device, DeviceOption }

  @doc """
  Returns the list of experiments.

  ## Examples

      iex> list_experiments()
      [%Experiment{}, ...]

  """
  def list_experiments do
    Repo.all(Experiment)
  end

  @doc """
  Gets a single experiment.

  Raises `Ecto.NoResultsError` if the Experiment does not exist.

  ## Examples

      iex> get_experiment!(123)
      %Experiment{}

      iex> get_experiment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_experiment!(id), do: Repo.get!(Experiment, id) |> Repo.preload([:options])

  @doc """
  Creates a experiment.

  ## Examples

      iex> create_experiment(%{field: value})
      {:ok, %Experiment{}}

      iex> create_experiment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_experiment(attrs \\ %{}) do
    %Experiment{}
    |> Experiment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a experiment.

  ## Examples

      iex> update_experiment(experiment, %{field: new_value})
      {:ok, %Experiment{}}

      iex> update_experiment(experiment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_experiment(%Experiment{} = experiment, attrs) do
    experiment
    |> Experiment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Experiment.

  ## Examples

      iex> delete_experiment(experiment)
      {:ok, %Experiment{}}

      iex> delete_experiment(experiment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_experiment(%Experiment{} = experiment) do
    Repo.delete(experiment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking experiment changes.

  ## Examples

      iex> change_experiment(experiment)
      %Ecto.Changeset{source: %Experiment{}}

  """
  def change_experiment(%Experiment{} = experiment) do
    Experiment.changeset(experiment, %{})
  end

  @doc """
  Preload options for experiment

  ## Examples

      iex> preload_options_for_experiment(experiment)
      %Experiment{key: "some_key", optins: [...%Option{}]}

  """

  def preload_options_for_experiment(experiment) do
    experiment |> Repo.preload(:options)
  end

  @doc """
  Creates a device.

  ## Examples

      iex> create_device(%{token: value})
      {:ok, %Device{}}

      iex> create_device(%{token: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_device(attrs \\ %{}) do
    %Device{}
    |> Device.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Find or creates a device by token.

  ## Examples

      iex> find_or_create_device_by_token(token)
      %Device{}
  """

  def find_or_create_device_by_token(token) do
    case Repo.get_by(Device, token: token) do
      nil ->
        {:ok, device} = create_device(%{token: token})
        device
      device -> device
    end
  end

  @doc """
  List experiments not distributed for device.

  ## Examples

      iex> experiments_not_distrubuted_for_device(device)
      [...%Experiment{}]
  """

  def experiments_not_distrubuted_for_device(device) do
    experiments_all = Repo.all(Experiment)
    %{experiments: device_experiments} = Repo.preload(device, :experiments)

    Enum.filter(experiments_all, fn e -> not Enum.member?(device_experiments, e) end)
  end

  @doc """
  List distributed Experiment Option for device.

  ## Examples

      iex> experiments_not_distrubuted_for_device(device)
      [...%Experiment{}]
  """

  def distributed_experiment_options_for_device(device) do
    %{options: options} = Repo.preload(device, [options: :experiment])
    options
  end

  @doc """
  Creates a device_option.

  ## Examples

      iex> create_device_option(device, option)
      {:ok, %DeviceOption{}}
  """

  def create_device_option(device, option) do
    %DeviceOption{device: device, option: option} |> Repo.insert()
  end

  @doc """
  Cache devices_count field.

  ## Examples

      iex> cache_devices_count(expirement)
      {:ok, %Expirement{}}

      iex> cache_devices_count(option)
      {:ok, %Option{}}
  """

  def cache_devices_count(%module{} = record) when module in [Experiment, Option] do
    count = count_devices(record)

    module.devices_count_changeset(record, %{devices_count: count})
    |> Repo.update()
  end

  defp count_devices(record) do
    record
    |> Ecto.assoc(:devices)
    |> Repo.aggregate(:count, :id)
  end
end
