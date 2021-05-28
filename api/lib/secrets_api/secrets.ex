defmodule SecretsApi.Secrets do
  @moduledoc """
  This module contains basic operations to safely
  store and retrieve secrets.
  """

  alias SecretsApi.Redix

  @spec store_secret(any) ::
          {:error, charlist()} | {:ok, binary}
  def store_secret(secret) do
    room_id = generate_room_id()

    case Redix.command(["SET", room_id, secret]) do
      {:ok, _} -> {:ok, room_id}
      _ -> {:error, :redis_error}
    end
  end

  @retrieve_lua_script """
    local secret = redis.call('get', KEYS[1])
    redis.call('del', KEYS[1])

    return secret
  """

  @spec retrieve_and_delete_secret(any) ::
          {:error, :not_found | :redis_error}
          | {:ok, binary}
  def retrieve_and_delete_secret(room_id) do
    case Redix.command(["EVAL", @retrieve_lua_script, 1, room_id]) do
      {:ok, nil} ->
        {:error, :not_found}

      {:ok, secret} ->
        {:ok, secret}

      _error ->
        {:error, :redis_error}
    end
  end

  defp generate_room_id do
    :crypto.strong_rand_bytes(8)
    |> Base.encode64(case: :lower)
    |> Base.url_encode64(case: :lower, padding: true)
  end
end