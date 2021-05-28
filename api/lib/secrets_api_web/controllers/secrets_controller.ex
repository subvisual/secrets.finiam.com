defmodule SecretsApiWeb.SecretsController do
  use SecretsApiWeb, :controller

  alias SecretsApi.Secrets

  action_fallback SecretsApiWeb.ErrorController

  def create(conn, %{"secret" => secret}) do
    with {:ok, room_id} <- Secrets.store_secret(secret) do
      json(conn, %{room_id: room_id})
    end
  end

  def show(conn, %{"id" => room_id}) do
    with {:ok, secret} <- Secrets.retrieve_and_delete_secret(room_id) do
      json(conn, %{secret: secret})
    end
  end
end
