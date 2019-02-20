defmodule AbTestApi.Repo do
  use Ecto.Repo,
    otp_app: :ab_test_api,
    adapter: Ecto.Adapters.Postgres
end
