defmodule SecretsWeb.ExampleController do
  use SecretsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json")
  end
end
