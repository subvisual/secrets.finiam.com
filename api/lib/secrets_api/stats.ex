defmodule SecretsApi.Stats do
  @moduledoc """
  This module allows for the storing of various
  properties useful for analytics.
  """
  import Ecto.Query, warn: false

  alias SecretsApi.Repo
  alias SecretsApi.Stats.KeyValue

  @secrets_counter "secrets_counter"

  @spec get_secrets_counter :: integer
  def get_secrets_counter do
    get_value(@secrets_counter)
  end

  @spec increment_secrets_counter :: integer
  def increment_secrets_counter do
    increment_value(@secrets_counter)
  end

  @spec set_secrets_counter(integer) :: integer
  def set_secrets_counter(value) when is_integer(value) do
    update_value(@secrets_counter, value)
  end

  defp insert_value(key, value) do
    %KeyValue{}
    |> KeyValue.changeset(%{key: key, value: to_string(value)})
    |> Repo.insert()
  end

  defp increment_value(key) do
    Ecto.Multi.new()
    |> Ecto.Multi.put(:key, key)
    |> Ecto.Multi.run(:key_value, fn _repo, %{key: key} -> get_value_or_initialize(key) end)
    |> Ecto.Multi.run(:value, fn _, %{key_value: key_value} ->
      {:ok, String.to_integer(key_value.value)}
    end)
    |> Ecto.Multi.update(:update, fn %{key_value: key_value, key: key, value: value} ->
      KeyValue.changeset(key_value, %{key: key, value: to_string(value + 1)})
    end)
    |> Repo.transaction()
    |> get_int_from_transaction()
  end

  defp update_value(key, value) do
    Ecto.Multi.new()
    |> Ecto.Multi.put(:key, key)
    |> Ecto.Multi.put(:value, value)
    |> Ecto.Multi.run(:key_value, fn _repo, %{key: key} -> get_value_or_initialize(key) end)
    |> Ecto.Multi.update(:update, fn %{key_value: key_value, key: key, value: value} ->
      KeyValue.changeset(key_value, %{key: key, value: to_string(value)})
    end)
    |> Repo.transaction()
    |> get_int_from_transaction()
  end

  defp get_value(key) do
    {:ok, result} = get_value_or_initialize(key)

    String.to_integer(result.value)
  end

  defp get_value_or_initialize(key) do
    case Repo.get_by(KeyValue, key: key) do
      nil -> insert_value(key, 0)
      value -> {:ok, value}
    end
  end

  defp get_int_from_transaction(transaction) do
    with {:ok, transaction_result} <- transaction do
      transaction_result.update.value
      |> String.to_integer()
    end
  end
end
