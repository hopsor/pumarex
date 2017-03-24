defmodule Pumarex.Theater do
  @moduledoc """
  The boundary for the Theater system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Pumarex.Repo

  alias Pumarex.Theater.Movie

  @doc """
  Returns the list of movies.

  ## Examples

      iex> list_movies()
      [%Movie{}, ...]

  """
  def list_movies do
    Repo.all(Movie)
  end

  @doc """
  Gets a single movie.

  Raises `Ecto.NoResultsError` if the Movie does not exist.

  ## Examples

      iex> get_movie!(123)
      %Movie{}

      iex> get_movie!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movie!(id), do: Repo.get!(Movie, id)

  @doc """
  Creates a movie.

  ## Examples

      iex> create_movie(movie, %{field: value})
      {:ok, %Movie{}}

      iex> create_movie(movie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movie(attrs \\ %{}) do
    %Movie{}
    |> movie_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a movie.

  ## Examples

      iex> update_movie(movie, %{field: new_value})
      {:ok, %Movie{}}

      iex> update_movie(movie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movie(%Movie{} = movie, attrs) do
    movie
    |> movie_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Movie.

  ## Examples

      iex> delete_movie(movie)
      {:ok, %Movie{}}

      iex> delete_movie(movie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movie(%Movie{} = movie) do
    Repo.delete(movie)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movie changes.

  ## Examples

      iex> change_movie(movie)
      %Ecto.Changeset{source: %Movie{}}

  """
  def change_movie(%Movie{} = movie) do
    movie_changeset(movie, %{})
  end

  defp movie_changeset(%Movie{} = movie, attrs) do
    movie
    |> cast(attrs, [:title, :year, :duration, :director, :cast, :overview, :poster])
    |> validate_required([:title, :year, :duration, :director, :cast, :overview, :poster])
  end

  alias Pumarex.Theater.Room

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Repo.all(from r in Room,
      left_join: s in assoc(r, :seats),
      group_by: r.id,
      select: %{id: r.id, name: r.name, capacity: count(s.id)}
    )
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id) |> Repo.preload(:seats)

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(room, %{field: value})
      {:ok, %Room{}}

      iex> create_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> room_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> room_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{source: %Room{}}

  """
  def change_room(%Room{} = room) do
    room_changeset(room, %{})
  end

  defp room_changeset(%Room{} = room, params) do
    room
    |> cast(params, [:name])
    |> validate_required(:name)
    |> cast_assoc(:seats, required: true, with: &seat_changeset/2)
  end

  alias Pumarex.Theater.Seat

  @doc """
  Returns the list of seats.

  ## Examples

      iex> list_seats()
      [%Seat{}, ...]

  """
  def list_seats do
    Repo.all(Seat)
  end

  @doc """
  Gets a single seat.

  Raises `Ecto.NoResultsError` if the Seat does not exist.

  ## Examples

      iex> get_seat!(123)
      %Seat{}

      iex> get_seat!(456)
      ** (Ecto.NoResultsError)

  """
  def get_seat!(id), do: Repo.get!(Seat, id)

  @doc """
  Creates a seat.

  ## Examples

      iex> create_seat(%{field: value})
      {:ok, %Seat{}}

      iex> create_seat(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_seat(attrs \\ %{}) do
    %Seat{}
    |> seat_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a seat.

  ## Examples

      iex> update_seat(seat, %{field: new_value})
      {:ok, %Seat{}}

      iex> update_seat(seat, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_seat(%Seat{} = seat, attrs) do
    seat
    |> seat_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Seat.

  ## Examples

      iex> delete_seat(seat)
      {:ok, %Seat{}}

      iex> delete_seat(seat)
      {:error, %Ecto.Changeset{}}

  """
  def delete_seat(%Seat{} = seat) do
    Repo.delete(seat)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking seat changes.

  ## Examples

      iex> change_seat(seat)
      %Ecto.Changeset{source: %Seat{}}

  """
  def change_seat(%Seat{} = seat) do
    seat_changeset(seat, %{})
  end

  defp seat_changeset(%Seat{} = seat, attrs) do
    seat
    |> cast(attrs, [:row, :column])
    |> validate_required([:row, :column])
  end
end
