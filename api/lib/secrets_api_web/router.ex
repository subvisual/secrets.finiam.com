defmodule SecretsApiWeb.Router do
  use SecretsApiWeb, :router

  import Phoenix.LiveDashboard.Router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  pipeline :auth do
    import Plug.BasicAuth

    plug :basic_auth, Application.compile_env(:secrets_api, :basic_auth)
  end

  scope "/api", SecretsApiWeb do
    pipe_through :api

    head "/secrets/:id", SecretsController, :head
    resources "/secrets", SecretsController, only: [:show, :create, :delete]
    resources "/stats", StatsController, only: [:index]

    options "/*path", SecretsController, :options
  end

  scope "/" do
    pipelines =
      if Mix.env() in [:dev, :test] do
        [:fetch_session, :protect_from_forgery]
      else
        [:fetch_session, :protect_from_forgery, :auth]
      end

    pipe_through pipelines
    live_dashboard "/dashboard", metrics: SecretsApiWeb.Telemetry
  end
end
