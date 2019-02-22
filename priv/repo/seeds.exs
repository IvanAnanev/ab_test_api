# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AbTestApi.Repo.insert!(%AbTestApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias AbTestApi.Repo
alias AbTestApi.ABTests
alias AbTestApi.ABTests.{ Experiment, Option, Device }
alias AbTestApi.Distributor

# button_color
{:ok, e1} = ABTests.create_experiment(%{
  key: "button_color",
  options: [
    %{value: "#FF0000", percentage: 33},
    %{value: "#00FF00", percentage: 33},
    %{value: "#0000FF", percentage: 33}
  ]
})
# price
{:ok, e2} = ABTests.create_experiment(%{
  key: "price",
  options: [
    %{value: "10", percentage: 75},
    %{value: "20", percentage: 10},
    %{value: "50", percentage: 5},
    %{value: "5", percentage: 10}
  ]
})

Enum.each(1..300, fn(_) ->
  token = :crypto.strong_rand_bytes(20) |> Base.url_encode64 |> binary_part(0, 20)
  {:ok, device} = ABTests.create_device(%{token: token})
  e_1 = ABTests.get_experiment!(e1.id)
  Distributor.call(e_1, device)
  e_2 = ABTests.get_experiment!(e2.id)
  Distributor.call(e_2, device)
end)