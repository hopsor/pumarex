defmodule Pumarex.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pumarex.Accounts.User


  schema "accounts_users" do
    field :email, :string
    field :encrypted_password, :string
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :encrypted_password])
    |> validate_required([:first_name, :last_name, :email, :encrypted_password])
  end
end
