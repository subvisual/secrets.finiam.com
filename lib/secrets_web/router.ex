defmodule SecretsWeb.Router do
  use SecretsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: "*"

    plug :accepts, ["json"]
  end

  scope "/api", SecretsWeb do
    pipe_through :api

    get "/example", ExampleController, :index
  end

  scope "/", SecretsWeb do
    pipe_through :browser

    get "/*path", PageController, :index
  end
end
