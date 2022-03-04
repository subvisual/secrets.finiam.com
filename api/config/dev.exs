import Config

config :secrets_api, SecretsApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "secrets_api_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :secrets_api, SecretsApiWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
