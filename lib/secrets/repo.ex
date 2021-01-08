defmodule PhoenixStarter.Repo do
  use Ecto.Repo,
    otp_app: :secrets,
    adapter: Ecto.Adapters.Postgres
end
