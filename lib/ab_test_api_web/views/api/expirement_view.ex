defmodule AbTestApiWeb.Api.ExperimentView do
  use AbTestApiWeb, :view

  def render("index.json", %{options: options}) do
    Enum.map(options, fn(opt) ->
      %{key: opt.experiment.key, value: opt.value}
    end)
  end
end
