defmodule Pumarex.Theater.Room do
  use Ecto.Schema
  
  schema "theater_rooms" do
    field :name, :string

    timestamps()
  end
end
