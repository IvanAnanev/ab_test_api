defmodule AbTestApiWeb.ExperimentView do
  use AbTestApiWeb, :view
  alias AbTestApi.ABTests
  alias AbTestApi.ABTests.{ Experiment, Option }

  def link_add_option do
    changeset = ABTests.change_experiment(%Experiment{options: [%Option{value: "some_value", percentage: 50}]})
    form = Phoenix.HTML.FormData.to_form(changeset, [])
    fields =render_to_string(__MODULE__, "option_fields.html", f: form)
    link "Add Option", to: "#", "data-template": fields, id: "add_option"
  end
end
