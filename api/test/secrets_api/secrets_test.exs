defmodule SecretsApi.SecretsTest do
  use SecretsApiWeb.ConnCase, async: true

  alias SecretsApi.Secrets

  test "stores some string and assigns it a room id" do
    secret = "something"
    {:ok, room_id} = Secrets.store_secret(secret)

    assert is_binary(room_id)
  end

  test "retrieves an already stored secret" do
    secret = "something"
    {:ok, room_id} = Secrets.store_secret(secret)
    {:ok, retrieved_secret} = Secrets.retrieve_and_delete_secret(room_id)

    assert secret == retrieved_secret
  end

  test "deletes a secret after retrieval" do
    secret = "something"
    {:ok, room_id} = Secrets.store_secret(secret)
    {:ok, _} = Secrets.retrieve_and_delete_secret(room_id)

    assert {:error, :not_found} = Secrets.retrieve_and_delete_secret(room_id)
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
end
