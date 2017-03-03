defmodule Pumarex.TheaterTest do
  use Pumarex.DataCase

  alias Pumarex.Theater
  alias Pumarex.Theater.Movie

  @create_attrs %{cast: "some cast", director: "some director", duration: 42, overview: "some overview", poster: "some poster", title: "some title", year: 42}
  @update_attrs %{cast: "some updated cast", director: "some updated director", duration: 43, overview: "some updated overview", poster: "some updated poster", title: "some updated title", year: 43}
  @invalid_attrs %{cast: nil, director: nil, duration: nil, overview: nil, poster: nil, title: nil, year: nil}

  def fixture(:movie, attrs \\ @create_attrs) do
    {:ok, movie} = Theater.create_movie(attrs)
    movie
  end

  test "list_movies/1 returns all movies" do
    movie = fixture(:movie)
    assert Theater.list_movies() == [movie]
  end

  test "get_movie! returns the movie with given id" do
    movie = fixture(:movie)
    assert Theater.get_movie!(movie.id) == movie
  end

  test "create_movie/1 with valid data creates a movie" do
    assert {:ok, %Movie{} = movie} = Theater.create_movie(@create_attrs)
    
    assert movie.cast == "some cast"
    assert movie.director == "some director"
    assert movie.duration == 42
    assert movie.overview == "some overview"
    assert movie.poster == "some poster"
    assert movie.title == "some title"
    assert movie.year == 42
  end

  test "create_movie/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Theater.create_movie(@invalid_attrs)
  end

  test "update_movie/2 with valid data updates the movie" do
    movie = fixture(:movie)
    assert {:ok, movie} = Theater.update_movie(movie, @update_attrs)
    assert %Movie{} = movie
    
    assert movie.cast == "some updated cast"
    assert movie.director == "some updated director"
    assert movie.duration == 43
    assert movie.overview == "some updated overview"
    assert movie.poster == "some updated poster"
    assert movie.title == "some updated title"
    assert movie.year == 43
  end

  test "update_movie/2 with invalid data returns error changeset" do
    movie = fixture(:movie)
    assert {:error, %Ecto.Changeset{}} = Theater.update_movie(movie, @invalid_attrs)
    assert movie == Theater.get_movie!(movie.id)
  end

  test "delete_movie/1 deletes the movie" do
    movie = fixture(:movie)
    assert {:ok, %Movie{}} = Theater.delete_movie(movie)
    assert_raise Ecto.NoResultsError, fn -> Theater.get_movie!(movie.id) end
  end

  test "change_movie/1 returns a movie changeset" do
    movie = fixture(:movie)
    assert %Ecto.Changeset{} = Theater.change_movie(movie)
  end
end
