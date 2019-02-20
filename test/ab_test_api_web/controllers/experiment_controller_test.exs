defmodule AbTestApiWeb.ExperimentControllerTest do
  use AbTestApiWeb.ConnCase

  alias AbTestApi.ABTests

  @create_attrs %{count_cache: 42, key: "some key"}
  @update_attrs %{count_cache: 43, key: "some updated key"}
  @invalid_attrs %{count_cache: nil, key: nil}

  def fixture(:experiment) do
    {:ok, experiment} = ABTests.create_experiment(@create_attrs)
    experiment
  end

  describe "index" do
    test "lists all experiments", %{conn: conn} do
      conn = get(conn, Routes.experiment_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Experiments"
    end
  end

  describe "new experiment" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.experiment_path(conn, :new))
      assert html_response(conn, 200) =~ "New Experiment"
    end
  end

  describe "create experiment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.experiment_path(conn, :create), experiment: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.experiment_path(conn, :show, id)

      conn = get(conn, Routes.experiment_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Experiment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.experiment_path(conn, :create), experiment: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Experiment"
    end
  end

  describe "edit experiment" do
    setup [:create_experiment]

    test "renders form for editing chosen experiment", %{conn: conn, experiment: experiment} do
      conn = get(conn, Routes.experiment_path(conn, :edit, experiment))
      assert html_response(conn, 200) =~ "Edit Experiment"
    end
  end

  describe "update experiment" do
    setup [:create_experiment]

    test "redirects when data is valid", %{conn: conn, experiment: experiment} do
      conn = put(conn, Routes.experiment_path(conn, :update, experiment), experiment: @update_attrs)
      assert redirected_to(conn) == Routes.experiment_path(conn, :show, experiment)

      conn = get(conn, Routes.experiment_path(conn, :show, experiment))
      assert html_response(conn, 200) =~ "some updated key"
    end

    test "renders errors when data is invalid", %{conn: conn, experiment: experiment} do
      conn = put(conn, Routes.experiment_path(conn, :update, experiment), experiment: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Experiment"
    end
  end

  describe "delete experiment" do
    setup [:create_experiment]

    test "deletes chosen experiment", %{conn: conn, experiment: experiment} do
      conn = delete(conn, Routes.experiment_path(conn, :delete, experiment))
      assert redirected_to(conn) == Routes.experiment_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.experiment_path(conn, :show, experiment))
      end
    end
  end

  defp create_experiment(_) do
    experiment = fixture(:experiment)
    {:ok, experiment: experiment}
  end
end
