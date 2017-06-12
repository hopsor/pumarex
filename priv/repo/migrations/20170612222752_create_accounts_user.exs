defmodule Pumarex.Repo.Migrations.CreatePumarex.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :encrypted_password, :string

      timestamps()
    end

  end
end
