defmodule SecretsApiWeb.SecretsControllerTests do
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

    test "returns 404 if the room id doesn't exist", %{conn: conn} do
      room_id = "fake room id"
      conn = get(conn, Routes.secrets_path(conn, :show, room_id))

      assert %{
               "error" => "not_found"
             } = json_response(conn, 404)
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
  end
end
