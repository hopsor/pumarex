defmodule Pumarex.Web.RoomView do
  use Pumarex.Web, :view
  alias Pumarex.Web.{RoomView, SeatView}

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, RoomView, "room.json")}
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, RoomView, "room+seats.json")}
  end

  def render("room.json", %{room: room}) do
    %{id: room.id,
      name: room.name,
      seats_count: room.seats_count}
  end

  def render("room+seats.json", %{room: room}) do
    %{id: room.id,
      name: room.name,
      seats: render_many(room.seats, SeatView, "seat.json")}
  end
end
