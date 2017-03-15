defmodule Pumarex.Repo.Migrations.CreatePumarex.Theater.Seat do
  use Ecto.Migration

  def change do
    create table(:theater_seats) do
      add :row, :integer
      add :column, :integer
      add :room_id, references(:theater_rooms, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:theater_seats, [:row, :column, :room_id], name: :seats_unique_index)
    create index(:theater_seats, [:room_id])
  end
end
