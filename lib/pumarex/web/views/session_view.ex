defmodule Pumarex.Web.SessionView do
  use Pumarex.Web, :view
  alias Pumarex.Web.SessionView
  alias Pumarex.Accounts.User

  def render("show.json", %{session: session}) do
    render_one(session, SessionView, "session.json")
  end

  def render("session.json", %{session: session}) do
    %{
      id: session.user.id,
      first_name: session.user.first_name,
      last_name: session.user.last_name,
      email: session.user.email,
      jwt: session.jwt,
      exp: session.exp,
      avatar_url: User.avatar_url(session.user)
    }
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end
