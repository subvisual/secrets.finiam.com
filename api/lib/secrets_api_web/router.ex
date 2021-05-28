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

    resources "/secrets", SecretsController, only: [:show, :create]

    options "/*path", SecretsController, :options
  end

  if Mix.env() in [:dev, :test] do
    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: SecretsApiWeb.Telemetry
    end
  else
    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery, :auth]
      live_dashboard "/dashboard", metrics: SecretsApiWeb.Telemetry
    end
  end
end
