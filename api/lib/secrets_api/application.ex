defmodule SecretsApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      SecretsApi.Repo,
      SecretsApiWeb.Telemetry,
      {Phoenix.PubSub, name: SecretsApi.PubSub},
      SecretsApi.Redix,
      SecretsApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SecretsApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SecretsApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
