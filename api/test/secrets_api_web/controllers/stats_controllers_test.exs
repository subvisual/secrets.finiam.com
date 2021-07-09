defmodule SecretsApiWeb.StatsControllerTests do
  use SecretsApi.DataCase
  use SecretsApiWeb.ConnCase, async: true

  alias SecretsApi.Stats

  describe "index" do
    test "renders the stats", %{conn: conn} do
      Stats.set_secrets_counter(5)

      conn = get(conn, Routes.stats_path(conn, :index))

      assert %{
               "secrets_counter" => 5
             } = json_response(conn, 200)
    end
  end
end
