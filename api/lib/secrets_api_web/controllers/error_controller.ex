defmodule SecretsApiWeb.ErrorController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.
  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use SecretsApiWeb, :controller

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(SecretsApiWeb.ErrorView)
    |> render(:"401")
  end

  # Enable later on when we setup ecto
  # def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
  #   conn
  #   |> put_status(:unprocessable_entity)
  #   |> put_view(SecretsApiWeb.ChangesetView)
  #   |> render("error.json", changeset: changeset)
  # end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(SecretsApiWeb.ErrorView)
    |> render(:"400")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(SecretsApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, _error) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(SecretsApiWeb.ErrorView)
    |> render(:"500")
  end
end
