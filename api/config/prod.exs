import Config

config :secrets_api, SecretsApiWeb.Endpoint,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  check_origin: false

config :logger, level: :info

import_config "prod.secret.exs"
