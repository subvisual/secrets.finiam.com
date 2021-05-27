use Mix.Config

config :secrets, SecretsWeb.Endpoint,
  http: [port: 4002],
  server: true

config :wallaby,
  driver: Wallaby.Chrome,
  chrome: [headless: true],
  screenshot_on_failure: false

# Print only warnings and errors during test
config :logger, level: :warn
