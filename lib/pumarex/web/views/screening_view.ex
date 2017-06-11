defmodule Pumarex.Web.ScreeningView do
  use Pumarex.Web, :view
  alias Pumarex.Web.{ScreeningView, MovieView, RoomView}

  def render("index.json", %{screenings: screenings}) do
    render_many(screenings, ScreeningView, "screening.json")
  end

  def render("show.json", %{screening: screening}) do
    render_one(screening, ScreeningView, "screening.json")
  end

  def render("screening.json", %{screening: screening}) do
    %{id: screening.id,
      screened_at: screening.screened_at,
      room: render_one(screening.room, RoomView, "lite_room.json"),
      movie: render_one(screening.movie, MovieView, "movie.json")}
  end
end
