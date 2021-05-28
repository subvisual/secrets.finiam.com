defmodule SecretsApiWeb.ErrorView do
  use SecretsApiWeb, :view

  def render("401.json", _assigns) do
    %{error: "unauthorized"}
  end

  def render("400.json", _assigns) do
    %{error: "bad_request"}
  end

  def render("404.json", _assigns) do
    %{error: "not_found"}
  end

  def render("500.json", _assigns) do
    %{error: "internal_server_error"}
  end

  def template_not_found(template, _assigns) do
    error =
      Phoenix.Controller.status_message_from_template(template)
      |> Phoenix.Naming.underscore()
      |> String.replace(" ", "")

    %{error: error}
  end
end
