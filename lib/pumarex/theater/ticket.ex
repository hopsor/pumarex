defmodule Pumarex.Theater.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pumarex.Theater.Ticket


  schema "theater_tickets" do
    belongs_to :screening, Pumarex.Theater.Screening
    belongs_to :seller, Pumarex.Theater.User
    belongs_to :seat, Pumarex.Theater.Seat

    timestamps()
  end

  @doc false
  def changeset(%Ticket{} = ticket, attrs) do
    ticket
    |> cast(attrs, [:screening_id, :seller_id, :seat_id])
    |> validate_required([:screening_id, :seller_id, :seat_id])
  end
end
