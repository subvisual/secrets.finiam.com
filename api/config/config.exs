# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :secrets_api, SecretsApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QHLDf+nEYrZd9h6F5k6uTPP9/ulcy3ggt2K047ALK9Ezqge3SaEpVX5JwbB7joCz",
  render_errors: [view: SecretsApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SecretsApi.PubSub,
  live_view: [signing_salt: "rwQEhrSp"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

secrets_adapter = System.get_env("SECRETS_ADAPTER") || "REDIS"

case secrets_adapter do
  "REDIS" ->
    config :secrets_api, SecretsApi.Secrets, adapter: SecretsApi.Secrets.Redis

    config :secrets_api,
      redis_url: System.get_env("REDIS_URL") || "redis://localhost:6379"
end

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
