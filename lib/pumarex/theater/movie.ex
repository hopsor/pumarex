defmodule Pumarex.Theater.Movie do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pumarex.Theater.Movie

  schema "theater_movies" do
    field :title, :string
    field :year, :integer
    field :duration, :integer
    field :director, :string
    field :cast, :string
    field :overview, :string
    field :poster, :string
    field :banner, :string

    timestamps()
  end

  @doc false
  def changeset(%Movie{} = movie, attrs) do
    movie
    |> cast(attrs, [:title, :year, :duration, :director, :cast, :overview, :poster, :banner])
    |> validate_required([:title, :year, :duration, :director, :cast, :overview, :poster, :banner])
  end
end
