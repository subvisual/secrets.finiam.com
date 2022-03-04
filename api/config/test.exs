import Config

config :secrets_api, SecretsApi.Repo,
  username: "postgres",
  password: "postgres",
  database: "secrets_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :secrets_api, SecretsApiWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
