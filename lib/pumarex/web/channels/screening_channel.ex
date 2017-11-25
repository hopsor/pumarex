defmodule Pumarex.Web.ScreeningChannel do
  use Pumarex.Web, :channel
  alias Pumarex.Web.Presence
  alias Pumarex.Accounts.User
  alias Pumarex.Theater
  alias Pumarex.SeatLocking.Monitor

  def join("screening:" <> screening_id, payload, socket) do
    if authorized?(payload) do
      Monitor.create(screening_id)
      send(self(), :after_join)
      {:ok, assign(socket, :screening_id, screening_id)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    user = Guardian.Phoenix.Socket.current_resource(socket)
    screening_id = socket.assigns[:screening_id]

    push(socket, "presence_state", Presence.list(socket))
    push(socket, "room_loaded", load_room(socket))
    push(socket, "locked_seats", %{locked_seats: Monitor.locked_seats(screening_id)})
    push(socket, "sold_seats", %{sold_seats: sold_seat_ids(screening_id)})

    {:ok, _} =
      Presence.track(socket, user.id, %{
        id: user.id,
        full_name: User.full_name(user),
        avatar: User.avatar_url(user)
      })

    {:noreply, socket}
  end

  def handle_in("seat_status", %{"seat_id" => seat_id}, socket) do
    user = Guardian.Phoenix.Socket.current_resource(socket)

    locked_seats =
      Monitor.switch_lock(socket.assigns[:screening_id], %{seat_id: seat_id, user_id: user.id})

    broadcast!(socket, "locked_seats", %{locked_seats: locked_seats})
    {:noreply, socket}
  end

  def handle_in("sell_tickets", %{"seat_ids" => seat_ids}, socket) do
    user = Guardian.Phoenix.Socket.current_resource(socket)
    screening_id = socket.assigns[:screening_id]

    tickets_to_sell =
      Enum.map(seat_ids, fn seat_id ->
        %{seat_id: seat_id, seller_id: user.id, screening_id: String.to_integer(screening_id)}
      end)

    # 1. Create tickets
    Theater.create_tickets(tickets_to_sell)

    # 2. Remove locks
    Monitor.unlock_seats(screening_id, seat_ids)

    # 3. Reload and broadcast tickets and locks
    broadcast!(socket, "locked_seats", %{locked_seats: Monitor.locked_seats(screening_id)})
    broadcast!(socket, "sold_seats", %{sold_seats: sold_seat_ids(screening_id)})

    {:noreply, socket}
  end

  # TODO: Prevent clearing when the same user still keeps one session or more
  # open in different devices
  def terminate(_reason, socket) do
    user = Guardian.Phoenix.Socket.current_resource(socket)
    locked_seats = Monitor.clear_locks_from_user(socket.assigns[:screening_id], user.id)
    broadcast!(socket, "locked_seats", %{locked_seats: locked_seats})
    :ok
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  defp load_room(socket) do
    screening = Theater.get_screening!(socket.assigns[:screening_id])
    room = Theater.get_room!(screening.room_id)

    # TODO: Figure out if it's possible to re use RoomView code
    %{
      id: room.id,
      name: room.name,
      capacity: length(room.seats),
      seats:
        Enum.map(room.seats, fn seat ->
          %{id: seat.id, row: seat.row, column: seat.column}
        end)
    }
  end

  defp sold_seat_ids(screening_id) do
    screening_id
    |> Theater.list_tickets()
    |> Enum.map(fn ticket -> ticket.seat_id end)
  end
end
