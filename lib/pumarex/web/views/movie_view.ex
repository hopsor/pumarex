defmodule Pumarex.Web.MovieView do
  use Pumarex.Web, :view
  alias Pumarex.Web.MovieView

  def render("index.json", %{movies: movies}) do
    %{data: render_many(movies, MovieView, "movie.json")}
  end

  def render("show.json", %{movie: movie}) do
    %{data: render_one(movie, MovieView, "movie.json")}
  end

  def render("movie.json", %{movie: movie}) do
    %{id: movie.id,
      title: movie.title,
      year: movie.year,
      duration: movie.duration,
      director: movie.director,
      cast: movie.cast,
      overview: movie.overview,
      poster: movie.poster}
  end
end