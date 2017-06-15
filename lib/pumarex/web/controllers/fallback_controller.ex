defmodule Pumarex.Web.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use Pumarex.Web, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(Pumarex.Web.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(Pumarex.Web.ErrorView, :"404")
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> render(Pumarex.Web.ErrorView, "unauthenticated.json")
  end
end
