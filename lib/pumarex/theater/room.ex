defmodule Pumarex.Theater.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pumarex.Theater.Room

  schema "theater_rooms" do
    field(:name, :string)

    has_many(:seats, Pumarex.Theater.Seat)

    timestamps()
  end

  @doc false
  def changeset(%Room{} = room, params) do
    room
    |> cast(params, [:name])
    |> validate_required(:name)
    |> cast_assoc(:seats, required: true)
  end
end
