defmodule Pumarex.Repo.Migrations.CreatePumarex.Theater.Room do
  use Ecto.Migration

  def change do
    create table(:theater_rooms) do
      add :name, :string

      timestamps()
    end

  end
end
