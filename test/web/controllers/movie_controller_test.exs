defmodule Pumarex.Web.MovieControllerTest do
  use Pumarex.Web.ConnCase

  alias Pumarex.Theater
  alias Pumarex.Theater.Movie

  @create_attrs %{cast: "some cast", director: "some director", duration: 42, overview: "some overview", poster: "some poster", title: "some title", year: 42}
  @update_attrs %{cast: "some updated cast", director: "some updated director", duration: 43, overview: "some updated overview", poster: "some updated poster", title: "some updated title", year: 43}
  @invalid_attrs %{cast: nil, director: nil, duration: nil, overview: nil, poster: nil, title: nil, year: nil}

  def fixture(:movie) do
    {:ok, movie} = Theater.create_movie(@create_attrs)
    movie
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, movie_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates movie and renders movie when data is valid", %{conn: conn} do
    conn = post conn, movie_path(conn, :create), movie: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, movie_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "cast" => "some cast",
      "director" => "some director",
      "duration" => 42,
      "overview" => "some overview",
      "poster" => "some poster",
      "title" => "some title",
      "year" => 42}
  end

  test "does not create movie and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, movie_path(conn, :create), movie: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen movie and renders movie when data is valid", %{conn: conn} do
    %Movie{id: id} = movie = fixture(:movie)
    conn = put conn, movie_path(conn, :update, movie), movie: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, movie_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "cast" => "some updated cast",
      "director" => "some updated director",
      "duration" => 43,
      "overview" => "some updated overview",
      "poster" => "some updated poster",
      "title" => "some updated title",
      "year" => 43}
  end

  test "does not update chosen movie and renders errors when data is invalid", %{conn: conn} do
    movie = fixture(:movie)
    conn = put conn, movie_path(conn, :update, movie), movie: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen movie", %{conn: conn} do
    movie = fixture(:movie)
    conn = delete conn, movie_path(conn, :delete, movie)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, movie_path(conn, :show, movie)
    end
  end
end
