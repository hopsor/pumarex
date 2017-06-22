defmodule Pumarex.SeatLocking.Monitor do
  @moduledoc """
  Board monitor that keeps track of connected users.
  """

  use GenServer

  #####
  # External API

  def create(screening_id) do
    case GenServer.whereis(ref(screening_id)) do
      nil ->
        Supervisor.start_child(Pumarex.SeatLocking.Supervisor, [screening_id])
      _screening ->
        {:error, :screening_already_exists}
    end
  end

  def start_link(screening_id) do
    GenServer.start_link(__MODULE__, [], name: ref(screening_id))
  end

  def locked_seats(screening_id) do
    try_call screening_id, {:locked_seats}
  end

  def switch_lock(screening_id, seat) do
    try_call screening_id, {:switch_lock, seat}
  end

  def clear_locks_from_user(screening_id, user_id) do
    try_call screening_id, {:clear_locks_from_user, user_id}
  end

  #####
  # GenServer implementation

  def handle_call({:locked_seats}, _from, seats) do
    {:reply, seats, seats}
  end

  def handle_call({:switch_lock, seat}, _from, seats) do
    %{seat_id: seat_id, user_id: user_id} = seat

    updated_seats =
      Enum.find(seats, fn (s) -> s.seat_id == seat_id end)
      |> case do
        nil -> seats ++ [seat]
        %{user_id: uid} when uid == user_id -> seats -- [seat]
        %{user_id: uid} when uid != user_id -> seats
      end

    {:reply, updated_seats, updated_seats}
  end

  def handle_call({:clear_locks_from_user, user_id}, _from, seats) do
    seats = Enum.reject(seats, fn (seat) -> seat.user_id == user_id end)
    {:reply, seats, seats}
  end

  defp ref(screening_id) do
    {:global, {:screening, screening_id}}
  end

  defp try_call(screening_id, call_function) do
    case GenServer.whereis(ref(screening_id)) do
      nil ->
        {:error, :invalid_screening}
      screening ->
        GenServer.call(screening, call_function)
    end
  end
end
