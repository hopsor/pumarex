defmodule Pumarex.Theater do
  @moduledoc """
  The boundary for the Theater system.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi
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
    |> Movie.changeset(attrs)
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
    |> Movie.changeset(attrs)
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
    Movie.changeset(movie, %{})
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
    |> Room.changeset(attrs)
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
    |> Room.changeset(attrs)
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
    Room.changeset(room, %{})
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
    |> Seat.changeset(attrs)
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
    |> Seat.changeset(attrs)
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
    Seat.changeset(seat, %{})
  end

  alias Pumarex.Theater.Screening

  @doc """
  Returns the list of screenings.

  ## Examples

      iex> list_screenings()
      [%Screening{}, ...]

  """
  def list_screenings do
    Repo.all(Screening)
    |> Repo.preload([:movie, :room])
  end

  @doc """
  Gets a single screening.

  Raises `Ecto.NoResultsError` if the Screening does not exist.

  ## Examples

      iex> get_screening!(123)
      %Screening{}

      iex> get_screening!(456)
      ** (Ecto.NoResultsError)

  """
  def get_screening!(id), do: Repo.get!(Screening, id)

  @doc """
  Creates a screening.

  ## Examples

      iex> create_screening(%{field: value})
      {:ok, %Screening{}}

      iex> create_screening(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_screening(attrs \\ %{}) do
    %Screening{}
    |> Screening.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, screening} ->
        {:ok, Repo.preload(screening, [:room, :movie])}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Updates a screening.

  ## Examples

      iex> update_screening(screening, %{field: new_value})
      {:ok, %Screening{}}

      iex> update_screening(screening, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_screening(%Screening{} = screening, attrs) do
    screening
    |> Screening.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Screening.

  ## Examples

      iex> delete_screening(screening)
      {:ok, %Screening{}}

      iex> delete_screening(screening)
      {:error, %Ecto.Changeset{}}

  """
  def delete_screening(%Screening{} = screening) do
    Repo.delete(screening)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking screening changes.

  ## Examples

      iex> change_screening(screening)
      %Ecto.Changeset{source: %Screening{}}

  """
  def change_screening(%Screening{} = screening) do
    Screening.changeset(screening, %{})
  end

  alias Pumarex.Theater.Ticket

  @doc """
  Returns the list of tickets.

  ## Examples

      iex> list_tickets()
      [%Ticket{}, ...]

  """
  def list_tickets(screening_id \\ nil) do
    case screening_id do
      nil -> Repo.all(Ticket)
      _ -> where(Ticket, screening_id: ^screening_id) |> Repo.all
    end
  end

  @doc """
  Gets a single ticket.

  Raises `Ecto.NoResultsError` if the Ticket does not exist.

  ## Examples

      iex> get_ticket!(123)
      %Ticket{}

      iex> get_ticket!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ticket!(id), do: Repo.get!(Ticket, id)

  @doc """
  Creates a ticket.

  ## Examples

      iex> create_ticket(%{field: value})
      {:ok, %Ticket{}}

      iex> create_ticket(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ticket(attrs \\ %{}) do
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Repo.insert()
  end

  def create_tickets(tickets) do
    Multi.new
    |> insert_ticket_transaction(tickets)
    |> Repo.transaction
  end
  defp insert_ticket_transaction(multi, [ticket_attrs | tail]) do
    %{seat_id: seat_id, screening_id: screening_id} = ticket_attrs

    transaction_id =
      "ticket_" <> to_string(seat_id) <> "_" <> to_string(screening_id)

    multi
    |> Multi.insert(transaction_id, Ticket.changeset(%Ticket{}, ticket_attrs))
    |> insert_ticket_transaction(tail)
  end
  defp insert_ticket_transaction(multi, []), do: multi

  @doc """
  Updates a ticket.

  ## Examples

      iex> update_ticket(ticket, %{field: new_value})
      {:ok, %Ticket{}}

      iex> update_ticket(ticket, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ticket(%Ticket{} = ticket, attrs) do
    ticket
    |> Ticket.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ticket.

  ## Examples

      iex> delete_ticket(ticket)
      {:ok, %Ticket{}}

      iex> delete_ticket(ticket)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ticket(%Ticket{} = ticket) do
    Repo.delete(ticket)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ticket changes.

  ## Examples

      iex> change_ticket(ticket)
      %Ecto.Changeset{source: %Ticket{}}

  """
  def change_ticket(%Ticket{} = ticket) do
    Ticket.changeset(ticket, %{})
  end
end
