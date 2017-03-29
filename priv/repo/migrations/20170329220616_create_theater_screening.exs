defmodule Pumarex.Repo.Migrations.CreatePumarex.Theater.Screening do
  use Ecto.Migration

  def change do
    create table(:theater_screenings) do
      add :screened_at, :naive_datetime
      add :movie_id, references(:theater_movies, on_delete: :delete_all)
      add :room_id, references(:theater_rooms, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:theater_screenings, [:room_id, :screened_at], name: :screening_unique_index)
    create index(:theater_screenings, [:movie_id])
    create index(:theater_screenings, [:room_id])
  end
end
