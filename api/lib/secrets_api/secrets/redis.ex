defmodule SecretsApi.Secrets.Redis do
  @moduledoc """
  This module implements behaviour for basic operations to safely
  store and retrieve secrets with redis.
  """

  @behaviour SecretsApi.Secrets

  alias SecretsApi.Secrets.Redis.Redix

  require Logger

  def store_secret(secret) do
    room_id = generate_room_id()

    case Redix.command(["SET", room_id, secret, "EX", "3600", "NX"]) do
      {:ok, _} ->
        {:ok, room_id}

      {:error, error} ->
        Logger.error(error)
        {:error, :redis_error}
    end
  end

  def secret_exists(room_id) do
    case Redix.command(["EXISTS", room_id]) do
      {:ok, 1} ->
        {:ok}

      {:ok, _} ->
        {:error, :not_found}

      {:error, error} ->
        Logger.error(error)
        {:error, :redis_error}
    end
  end

  @retrieve_lua_script """
    local secret = redis.call('get', KEYS[1])
    redis.call('del', KEYS[1])

    return secret
  """

  def retrieve_and_delete_secret(room_id) do
    case Redix.command(["EVAL", @retrieve_lua_script, 1, room_id]) do
      {:ok, nil} ->
        {:error, :not_found}

      {:ok, secret} ->
        {:ok, secret}

      {:error, error} ->
        Logger.error(error)
        {:error, :redis_error}
    end
  end

  def delete_secret(room_id) do
    case Redix.command(["DEL", room_id]) do
      {:ok, 0} ->
        {:error, :not_found}

      {:ok, _} ->
        {:ok}

      {:error, error} ->
        Logger.error(error)
        {:error, :redis_error}
    end
  end

  defp generate_room_id do
    :crypto.strong_rand_bytes(8)
    |> Base.encode64(case: :lower)
    |> Base.url_encode64(case: :lower, padding: true)
  end
end
