defmodule SecretsApiWeb.ErrorViewTest do
  use SecretsApiWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(SecretsApiWeb.ErrorView, "404.json", []) == %{error: "not_found"}
  end

  test "renders 500.json" do
    assert render(SecretsApiWeb.ErrorView, "500.json", []) ==
             %{error: "internal_server_error"}
  end

  test "renders random_template.json" do
    assert render(SecretsApiWeb.ErrorView, "random_template.json", []) ==
             %{error: "internal_server_error"}
  end
end
