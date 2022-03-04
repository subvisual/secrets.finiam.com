import Config

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :secrets_api, SecretsApiWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :secrets_api, SecretsApi.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

admin_username =
  System.get_env("ADMIN_USERNAME") ||
    raise """
    environment variable ADMIN_USERNAME is missing.
    """

admin_password =
  System.get_env("ADMIN_PASSWORD") ||
    raise """
    environment variable ADMIN_PASSWORD is missing.
    """

config :secrets_api, :basic_auth, username: admin_username, password: admin_password
