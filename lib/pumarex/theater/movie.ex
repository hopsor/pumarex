defmodule Pumarex.Theater.Movie do
  use Ecto.Schema
  
  schema "theater_movies" do
    field :title, :string
    field :year, :integer
    field :duration, :integer
    field :director, :string
    field :cast, :string
    field :overview, :string
    field :poster, :string

    timestamps()
  end
end
