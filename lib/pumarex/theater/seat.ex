defmodule Pumarex.Theater.Seat do
  use Ecto.Schema

  schema "theater_seats" do
    field :column, :integer
    field :row, :integer
    field :room_id, :id

    belongs_to :room, Pumarex.Theater.Room

    timestamps()
  end
end
