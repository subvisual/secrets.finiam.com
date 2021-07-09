defmodule SecretsApi.SecretsTest do
  use SecretsApi.DataCase

  alias SecretsApi.Secrets
  alias SecretsApi.Stats

  describe "store_secret/1" do
    test "stores some string and assigns it a room id" do
      secret = "something"
      {:ok, room_id} = Secrets.store_secret(secret)

      assert is_binary(room_id)
    end

    test "increments the secrets_counter" do
      prev_counter = Stats.get_secrets_counter()
      secret = "something"

      Secrets.store_secret(secret)

      assert Stats.get_secrets_counter() == prev_counter + 1
    end
  end

  describe "retrieve_and_delete_secret/1" do
    test "retrieves an already stored secret" do
      secret = "something"
      {:ok, room_id} = Secrets.store_secret(secret)
      {:ok, retrieved_secret} = Secrets.retrieve_and_delete_secret(room_id)

      assert %{"has_passphrase" => false, "secret" => ^secret} = retrieved_secret
    end

    test "auto deletes a secret after retrieval" do
      secret = "something"
      {:ok, room_id} = Secrets.store_secret(secret)
      {:ok, _} = Secrets.retrieve_and_delete_secret(room_id)

      assert {:error, :not_found} = Secrets.retrieve_and_delete_secret(room_id)
    end
  end

  describe "secret_exists/1" do
    test "returns ok if secret exists" do
      secret = "something"
      {:ok, room_id} = Secrets.store_secret(secret)

      assert {:ok} = Secrets.secret_exists(room_id)
    end

    test "returns error not found if secret does not exist" do
      room_id = "bad room"

      assert {:error, :not_found} = Secrets.secret_exists(room_id)
    end
  end

  describe "delete_secret/1" do
    test "deletes a secret" do
      {:ok, room_id} = Secrets.store_secret("something")

      assert {:ok} = Secrets.delete_secret(room_id)
      assert {:error, :not_found} = Secrets.retrieve_and_delete_secret(room_id)
    end

    test "returns not found error" do
      assert {:error, :not_found} = Secrets.delete_secret("does not exist")
    end
  end
end
