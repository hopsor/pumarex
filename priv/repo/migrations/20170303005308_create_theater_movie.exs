defmodule Pumarex.Repo.Migrations.CreatePumarex.Theater.Movie do
  use Ecto.Migration

  def change do
    create table(:theater_movies) do
      add :title, :string
      add :year, :integer
      add :duration, :integer
      add :director, :string
      add :cast, :text
      add :overview, :text
      add :poster, :string
      add :banner, :string

      timestamps()
    end

  end
end
