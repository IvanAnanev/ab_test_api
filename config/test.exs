use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ab_test_api, AbTestApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :ab_test_api, AbTestApi.Repo,
  # username: "postgres",
  # password: "postgres",
  database: "ab_test_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
