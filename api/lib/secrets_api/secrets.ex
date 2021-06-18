defmodule SecretsApi.Secrets do
  import SecretsApi.Config, only: [config!: 2]

  @moduledoc """
  This module contains behaviour for basic operations to safely
  store and retrieve secrets.
  """

  @adapter config!(__MODULE__, :adapter)

  @callback store_secret(any) ::
              {:error, charlist()} | {:ok, binary}
  defdelegate store_secret(secret), to: @adapter

  @callback secret_exists(any) ::
              {:error, :not_found | :redis_error}
              | {:ok}
  defdelegate secret_exists(room_id), to: @adapter

  @callback retrieve_and_delete_secret(any) ::
              {:error, :not_found | :redis_error}
              | {:ok, binary}
  defdelegate retrieve_and_delete_secret(room_id), to: @adapter

  @callback delete_secret(any) :: {:ok} | {:error, :not_found | :redis_error}
  defdelegate delete_secret(room_id), to: @adapter
end
