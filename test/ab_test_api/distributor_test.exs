defmodule AbTestApi.DistributorTest do
  use AbTestApi.DataCase

  alias AbTestApi.Distributor
  alias AbTestApi.ABTests

  @exp_atr_1 %{
    key: "button_color",
    options: [
      %{value: "#FF0000", percentage: 33},
      %{value: "#00FF00", percentage: 33},
      %{value: "#0000FF", percentage: 33}
    ]
  }

  @exp_atr_2 %{
    key: "price",
    options: [
      %{value: "10", percentage: 75},
      %{value: "20", percentage: 10},
      %{value: "50", percentage: 5},
      %{value: "5", percentage: 10}
    ]
  }

  describe "distributor" do
    test "for first experiment" do
      {:ok, exp} = ABTests.create_experiment(@exp_atr_1)

      Enum.each(1..300, fn(_) ->
        {:ok, device} = ABTests.create_device(%{token: token()})
        e = ABTests.get_experiment!(exp.id)
        Distributor.call(e, device)
      end)

      experiment= ABTests.get_experiment!(exp.id)
      assert experiment.devices_count == 300
      Enum.each(experiment.options, fn (opt) ->
        assert opt.devices_count == 100
      end)
    end

    test "call for second experiment" do
      {:ok, exp} = ABTests.create_experiment(@exp_atr_2)

      Enum.each(1..300, fn(_) ->
        {:ok, device} = ABTests.create_device(%{token: token()})
        e = ABTests.get_experiment!(exp.id)
        Distributor.call(e, device)
      end)

      experiment= ABTests.get_experiment!(exp.id)
      assert experiment.devices_count == 300
      Enum.each(experiment.options, fn (opt) ->
        case opt.value do
          "10" -> opt.devices_count == 225
          "20" -> opt.devices_count == 30
          "50" -> opt.devices_count == 15
          "5" ->  opt.devices_count == 30
        end
      end)
    end
  end

  @token_length 20
  defp token() do
    :crypto.strong_rand_bytes(@token_length) |> Base.url_encode64 |> binary_part(0, @token_length)
  end
end