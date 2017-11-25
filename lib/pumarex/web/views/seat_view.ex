defmodule Pumarex.Web.SeatView do
  use Pumarex.Web, :view
  alias Pumarex.Web.SeatView

  def render("index.json", %{seats: seats}) do
    %{data: render_many(seats, SeatView, "seat.json")}
  end

  def render("show.json", %{seat: seat}) do
    %{data: render_one(seat, SeatView, "seat.json")}
  end

  def render("seat.json", %{seat: seat}) do
    %{id: seat.id, row: seat.row, column: seat.column}
  end
end
