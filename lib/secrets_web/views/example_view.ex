defmodule SecretsWeb.ExampleView do
  use SecretsWeb, :view

  def render("index.json", _) do
    %{message: "example"}
  end
end
