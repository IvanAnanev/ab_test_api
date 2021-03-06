defmodule AbTestApiWeb.Router do
  use AbTestApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AbTestApiWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/experiments", ExperimentController, only: [:new, :create, :show, :delete, :index]
  end

  # Other scopes may use custom stacks.
  scope "/api", AbTestApiWeb.Api, as: :api do
    pipe_through :api

    resources "/experiments", ExperimentController, only: [:index]
  end
end
