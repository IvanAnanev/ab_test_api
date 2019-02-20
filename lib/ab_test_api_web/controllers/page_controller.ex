defmodule AbTestApiWeb.PageController do
  use AbTestApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
