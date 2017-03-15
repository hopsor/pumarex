defmodule Pumarex.Theater.Room do
  use Ecto.Schema

  schema "theater_rooms" do
    field :name, :string

    has_many :seats, Pumarex.Theater.Seat

    timestamps()
  end
end
