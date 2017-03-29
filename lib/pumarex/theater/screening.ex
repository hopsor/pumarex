defmodule Pumarex.Theater.Screening do
  use Ecto.Schema

  schema "theater_screenings" do
    field :screened_at, :naive_datetime
    belongs_to :movie, Pumarex.Theater.Movie
    belongs_to :room, Pumarex.Theater.Room

    timestamps()
  end
end
