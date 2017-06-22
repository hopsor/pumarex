defmodule Pumarex.Theater.Screening do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pumarex.Theater.Screening

  schema "theater_screenings" do
    field :screened_at, :naive_datetime
    belongs_to :movie, Pumarex.Theater.Movie
    belongs_to :room, Pumarex.Theater.Room
    has_many :tickets, Pumarex.Theater.Ticket

    timestamps()
  end

  @doc false
  def changeset(%Screening{} = screening, attrs) do
    screening
    |> cast(attrs, [:screened_at, :movie_id, :room_id])
    |> validate_required([:screened_at, :movie_id, :room_id])
  end
end
