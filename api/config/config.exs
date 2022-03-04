import Config

config :secrets_api,
  ecto_repos: [SecretsApi.Repo]

config :secrets_api, SecretsApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QHLDf+nEYrZd9h6F5k6uTPP9/ulcy3ggt2K047ALK9Ezqge3SaEpVX5JwbB7joCz",
  render_errors: [view: SecretsApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SecretsApi.PubSub,
  live_view: [signing_salt: "rwQEhrSp"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason
config :phoenix, :filter_parameters, ["secret"]

redis_url = System.get_env("REDIS_URL") || "redis://localhost:6379"

config :secrets_api, redis_url: redis_url

import_config "#{config_env()}.exs"
