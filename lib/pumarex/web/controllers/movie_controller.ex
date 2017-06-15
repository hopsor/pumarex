defmodule Pumarex.Web.MovieController do
  use Pumarex.Web, :controller

  alias Pumarex.Theater
  alias Pumarex.Theater.Movie

  plug Guardian.Plug.EnsureAuthenticated, handler: Pumarex.Web.FallbackController
  action_fallback Pumarex.Web.FallbackController

  def index(conn, _params) do
    movies = Theater.list_movies()
    render(conn, "index.json", movies: movies)
  end

  def create(conn, %{"movie" => movie_params}) do
    with {:ok, %Movie{} = movie} <- Theater.create_movie(movie_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", movie_path(conn, :show, movie))
      |> render("show.json", movie: movie)
    end
  end

  def show(conn, %{"id" => id}) do
    movie = Theater.get_movie!(id)
    render(conn, "show.json", movie: movie)
  end

  def update(conn, %{"id" => id, "movie" => movie_params}) do
    movie = Theater.get_movie!(id)

    with {:ok, %Movie{} = movie} <- Theater.update_movie(movie, movie_params) do
      render(conn, "show.json", movie: movie)
    end
  end

  def delete(conn, %{"id" => id}) do
    movie = Theater.get_movie!(id)
    with {:ok, %Movie{}} <- Theater.delete_movie(movie) do
      send_resp(conn, :no_content, "")
    end
  end
end
