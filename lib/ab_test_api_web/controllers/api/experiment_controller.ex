defmodule AbTestApiWeb.Api.ExperimentController do
  use AbTestApiWeb, :controller

  alias AbTestApi.{ABTests, Distributor}

  def index(conn, _params) do
    device_token = get_req_header(conn, "device-token")

    case device_token do
      [] ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Need device token"})

      [token|_] ->
        device = ABTests.find_or_create_device_by_token(token)

        ABTests.experiments_not_distrubuted_for_device(device)
        |> Enum.each(fn(expirement) -> Distributor.call(expirement, device) end)

        render(conn, "index.json", options: ABTests.distributed_experiment_options_for_device(device))
    end
  end
end
