defmodule SecretsApi.MixProject do
  use Mix.Project

  @env Mix.env()

  def project do
    [
      app: :secrets_api,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {SecretsApi.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:cors_plug, "~> 3.0"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_enum, "~> 1.4"},
      {:ecto_sql, "~> 3.5"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix, "~> 1.6.0"},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:redix, "~> 1.1.2"}
      | deps(@env)
    ]
  end

  defp deps(env) when env in [:dev, :test] do
    [
      {:credo, "~> 1.6.0", runtime: false},
      {:phoenix_live_reload, "~> 1.2"}
    ]
  end

  defp deps(_), do: []

  defp aliases do
    [
      setup: ["deps.get"],
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: [
        "ecto.create --quiet",
        "ecto.migrate",
        "test"
      ]
    ]
  end
end
