defmodule AbTestApiWeb.ExperimentController do
  use AbTestApiWeb, :controller

  alias AbTestApi.ABTests
  alias AbTestApi.ABTests.{ Experiment, Option }

  def index(conn, _params) do
    experiments = ABTests.list_experiments()
    render(conn, "index.html", experiments: experiments)
  end

  def new(conn, _params) do
    changeset = ABTests.change_experiment(%Experiment{key: "new experiment", options: [
      %Option{value: "some_value_1", percentage: 50},
      %Option{value: "some_value_2", percentage: 50}
    ]})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"experiment" => experiment_params}) do
    case ABTests.create_experiment(experiment_params) do
      {:ok, experiment} ->
        conn
        |> put_flash(:info, "Experiment created successfully.")
        |> redirect(to: Routes.experiment_path(conn, :show, experiment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    experiment = ABTests.get_experiment!(id)
    render(conn, "show.html", experiment: experiment)
  end

  def delete(conn, %{"id" => id}) do
    experiment = ABTests.get_experiment!(id)
    {:ok, _experiment} = ABTests.delete_experiment(experiment)

    conn
    |> put_flash(:info, "Experiment deleted successfully.")
    |> redirect(to: Routes.experiment_path(conn, :index))
  end
end
