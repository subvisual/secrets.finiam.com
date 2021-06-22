defmodule SecretsApiWeb.SecretsControllerTests do
  use SecretsApi.DataCase
  use SecretsApiWeb.ConnCase, async: true

  alias SecretsApi.Secrets

  describe "show" do
    test "renders secret if the room id exists", %{conn: conn} do
      secret = "some secret"
      {:ok, room_id} = Secrets.store_secret(secret)
      conn = get(conn, Routes.secrets_path(conn, :show, room_id))

      assert %{
               "secret" => _secret
             } = json_response(conn, 200)
    end

    test "returns 404 after getting the secret one time", %{conn: conn} do
      secret = "some secret"
      {:ok, room_id} = Secrets.store_secret(secret)
      conn = get(conn, Routes.secrets_path(conn, :show, room_id))

      assert %{
               "secret" => _secret
             } = json_response(conn, 200)

      conn = get(conn, Routes.secrets_path(conn, :show, room_id))

      assert %{
               "error" => "not_found"
             } = json_response(conn, 404)
    end

    test "returns 404 if the room id doesn't exist", %{conn: conn} do
      room_id = "fake room id"
      conn = get(conn, Routes.secrets_path(conn, :show, room_id))

      assert %{
               "error" => "not_found"
             } = json_response(conn, 404)
    end
  end

  describe "head" do
    test "returns a ok status if secret exists", %{conn: conn} do
      secret = "some secret"
      {:ok, room_id} = Secrets.store_secret(secret)
      conn = head(conn, Routes.secrets_path(conn, :head, room_id))

      assert response(conn, 200) == ""
    end

    test "returns an ok status if checking twice", %{conn: conn} do
      secret = "some secret"
      {:ok, room_id} = Secrets.store_secret(secret)
      conn = head(conn, Routes.secrets_path(conn, :head, room_id))

      assert response(conn, 200) == ""

      conn = head(conn, Routes.secrets_path(conn, :head, room_id))

      assert response(conn, 200) == ""
    end

    test "returns 404 if the room id doesn't exist", %{conn: conn} do
      room_id = "fake room id"
      conn = head(conn, Routes.secrets_path(conn, :head, room_id))

      assert response(conn, 404) == ""
    end
  end

  describe "create" do
    test "renders room id after storing the secret", %{conn: conn} do
      secret = "some secret"
      conn = post(conn, Routes.secrets_path(conn, :create), %{"secret" => secret})

      assert %{
               "room_id" => _secret
             } = json_response(conn, 200)
    end

    test "accepts an expiry time", %{conn: conn} do
      secret = "some secret"
      expiry = 3600

      conn =
        post(conn, Routes.secrets_path(conn, :create), %{"secret" => secret, "expiry" => expiry})

      assert %{
               "room_id" => _secret
             } = json_response(conn, 200)
    end

    test "renders sets the passphrase requirement to true", %{conn: conn} do
      secret = "some secret"

      conn =
        post(conn, Routes.secrets_path(conn, :create), %{
          "secret" => secret,
          "has_passphrase" => true
        })

      %{
        "room_id" => room_id
      } = json_response(conn, 200)

      assert {:ok, %{"secret" => ^secret, "has_passphrase" => true}} =
               Secrets.retrieve_and_delete_secret(room_id)
    end
  end

  describe "delete" do
    test "returns ok if secret is deleted", %{conn: conn} do
      secret = "some secret"
      {:ok, room_id} = Secrets.store_secret(secret)
      conn = delete(conn, Routes.secrets_path(conn, :delete, room_id))

      assert response(conn, 200) == ""
    end
  end
end
