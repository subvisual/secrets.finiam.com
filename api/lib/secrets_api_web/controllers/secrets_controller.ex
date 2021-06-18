defmodule SecretsApiWeb.SecretsController do
  use SecretsApiWeb, :controller

  alias SecretsApi.Secrets

  action_fallback SecretsApiWeb.ErrorController

  def create(conn, %{"secret" => secret, "expiry" => expiry}) do
    with {:ok, room_id} <- Secrets.store_secret(secret, expiry) do
      json(conn, %{room_id: room_id})
    end
  end

  def create(conn, %{"secret" => secret}) do
    with {:ok, room_id} <- Secrets.store_secret(secret) do
      json(conn, %{room_id: room_id})
    end
  end

  def head(conn, %{"id" => room_id}) do
    with {:ok} <- Secrets.secret_exists(room_id) do
      send_resp(conn, 200, "")
    end
  end

  def show(conn, %{"id" => room_id}) do
    with {:ok, secret} <- Secrets.retrieve_and_delete_secret(room_id) do
      json(conn, %{secret: secret})
    end
  end

  def delete(conn, %{"id" => room_id}) do
    with {:ok} <- Secrets.delete_secret(room_id) do
      send_resp(conn, 200, "")
    end
  end
end
