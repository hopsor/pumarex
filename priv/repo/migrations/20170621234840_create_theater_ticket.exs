defmodule Pumarex.Repo.Migrations.CreatePumarex.Theater.Ticket do
  use Ecto.Migration

  def change do
    create table(:theater_tickets) do
      add :seller_id, references(:accounts_users, on_delete: :nothing)
      add :screening_id, references(:theater_screenings, on_delete: :nothing)
      add :seat_id, references(:theater_seats, on_delete: :nothing)

      timestamps()
    end

    create index(:theater_tickets, [:seller_id])
    create index(:theater_tickets, [:screening_id])
    create index(:theater_tickets, [:seat_id])
    create unique_index(:theater_tickets, [:screening_id, :seat_id], name: :tickets_unique_index)
  end
end
