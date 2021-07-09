defmodule SecretsApiWeb.StatsController do
  use SecretsApiWeb, :controller

  alias SecretsApi.Stats

  action_fallback SecretsApiWeb.ErrorController

  def index(conn, _params) do
    json(conn, %{secrets_counter: Stats.get_secrets_counter()})
  end
end
