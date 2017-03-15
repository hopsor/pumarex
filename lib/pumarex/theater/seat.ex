defmodule Pumarex.Theater.Seat do
  use Ecto.Schema

  schema "theater_seats" do
    field :column, :integer
    field :row, :integer

    belongs_to :room, Pumarex.Theater.Room

    timestamps()
  end
end
