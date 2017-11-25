defmodule Pumarex.Web.SessionController do
  use Pumarex.Web, :controller

  alias Pumarex.Accounts

  plug(:scrub_params, "user" when action in [:create])

  def create(conn, %{"user" => user_params}) do
    case Accounts.authenticate_user(user_params) do
      {:ok, user} ->
        new_conn = Guardian.Plug.api_sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)
        {:ok, claims} = Guardian.Plug.claims(new_conn)
        exp = Map.get(claims, "exp")

        new_conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> put_resp_header("x-expires", Integer.to_string(exp))
        |> render("show.json", session: %{user: user, jwt: jwt, exp: exp})

      {:error, message} ->
        conn
        |> put_status(401)
        |> render("error.json", message: message)
    end
  end
end
