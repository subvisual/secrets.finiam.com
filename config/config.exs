# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :secrets, SecretsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "Kdx7FKHM50+zw5MDplDK5tft3vfaVopA/lnX904SNtNgqcn+Ti3v9G7hk+GUH4E+",
  render_errors: [view: SecretsWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Secrets.PubSub,
  live_view: [signing_salt: "E6/tASpm"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
