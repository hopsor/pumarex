defmodule Pumarex.Theater.Seat do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pumarex.Theater.Seat

  schema "theater_seats" do
    field :column, :integer
    field :row, :integer

    belongs_to :room, Pumarex.Theater.Room

    timestamps()
  end

  @doc false
  def changeset(%Seat{} = seat, attrs) do
    seat
    |> cast(attrs, [:row, :column])
    |> validate_required([:row, :column])
  end
end
