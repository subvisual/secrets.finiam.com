defmodule SecretsApi.Repo do
  use Ecto.Repo,
    otp_app: :secrets_api,
    adapter: Ecto.Adapters.Postgres
end
