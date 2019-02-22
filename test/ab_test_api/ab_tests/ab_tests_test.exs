defmodule AbTestApi.ABTestsTest do
  use AbTestApi.DataCase

  alias AbTestApi.ABTests

  describe "experiments" do
    alias AbTestApi.ABTests.Experiment

    @valid_attrs %{devices_count: 42, key: "some key"}
    @update_attrs %{devices_count: 43, key: "some updated key"}
    @invalid_attrs %{devices_count: nil, key: nil}

    def experiment_fixture(attrs \\ %{}) do
      {:ok, experiment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ABTests.create_experiment()

      experiment
    end

    test "list_experiments/0 returns all experiments" do
      experiment = experiment_fixture()
      assert ABTests.list_experiments() == [experiment]
    end

    test "get_experiment!/1 returns the experiment with given id" do
      experiment = experiment_fixture()
      assert ABTests.get_experiment!(experiment.id) == experiment
    end

    test "create_experiment/1 with valid data creates a experiment" do
      assert {:ok, %Experiment{} = experiment} = ABTests.create_experiment(@valid_attrs)
      assert experiment.devices_count == 42
      assert experiment.key == "some key"
    end

    test "create_experiment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ABTests.create_experiment(@invalid_attrs)
    end

    test "update_experiment/2 with valid data updates the experiment" do
      experiment = experiment_fixture()
      assert {:ok, %Experiment{} = experiment} = ABTests.update_experiment(experiment, @update_attrs)
      assert experiment.devices_count == 43
      assert experiment.key == "some updated key"
    end

    test "update_experiment/2 with invalid data returns error changeset" do
      experiment = experiment_fixture()
      assert {:error, %Ecto.Changeset{}} = ABTests.update_experiment(experiment, @invalid_attrs)
      assert experiment == ABTests.get_experiment!(experiment.id)
    end

    test "delete_experiment/1 deletes the experiment" do
      experiment = experiment_fixture()
      assert {:ok, %Experiment{}} = ABTests.delete_experiment(experiment)
      assert_raise Ecto.NoResultsError, fn -> ABTests.get_experiment!(experiment.id) end
    end

    test "change_experiment/1 returns a experiment changeset" do
      experiment = experiment_fixture()
      assert %Ecto.Changeset{} = ABTests.change_experiment(experiment)
    end
  end
end
