defmodule Pumarex.Web.SessionView do
  use Pumarex.Web, :view
  alias Pumarex.Web.SessionView

  def render("show.json", %{session: session}) do
    render_one(session, SessionView, "session.json")
  end

  def render("session.json", %{session: session}) do
    %{id: session.user.id,
      first_name: session.user.first_name,
      last_name: session.user.last_name,
      email: session.user.email,
      jwt: session.jwt,
      exp: session.exp,
      avatar_url: avatar_url(session.user.email)}
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end

  defp avatar_url("john.doe@pumar.ex"), do: "http://tedfass.com/wp-content/uploads/bio35.jpg"
  defp avatar_url("jane.doe@pumar.ex"), do: "http://akns-images.eonline.com/eol_images/Entire_Site/201597/rs_300x300-151007061901-600.nicki-minaj-the-new-york-times-magazine.10715.jpg?downsize=600:*&crop=600:315;left,top"
  defp avatar_url(_), do: "https://lelakisihat.com/wp-content/uploads/2016/09/avatar.jpg"
end
