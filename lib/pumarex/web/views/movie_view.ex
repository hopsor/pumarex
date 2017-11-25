defmodule Pumarex.Web.MovieView do
  use Pumarex.Web, :view
  alias Pumarex.Web.MovieView

  def render("index.json", %{movies: movies}) do
    %{
      entries: render_many(movies, MovieView, "movie.json"),
      total_entries: length(movies),
      total_pages: 1,
      page_number: 1
    }
  end

  def render("show.json", %{movie: movie}) do
    render_one(movie, MovieView, "movie.json")
  end

  def render("movie.json", %{movie: movie}) do
    %{
      id: movie.id,
      title: movie.title,
      year: movie.year,
      duration: movie.duration,
      director: movie.director,
      cast: movie.cast,
      overview: movie.overview,
      poster: movie.poster,
      banner: movie.banner
    }
  end
end
