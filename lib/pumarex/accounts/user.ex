defmodule Pumarex.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pumarex.Accounts.User


  schema "accounts_users" do
    field :email, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password])
    |> validate_required([:email, :first_name, :last_name])
    |> validate_format(:email, ~r/@/)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> generate_encrypted_password
  end

  def full_name(%User{first_name: first_name, last_name: last_name}), do: first_name <> " " <> last_name
  def avatar_url(%User{email: "john.doe@pumar.ex"}), do: "http://tedfass.com/wp-content/uploads/bio35.jpg"
  def avatar_url(%User{email: "jane.doe@pumar.ex"}), do: "http://akns-images.eonline.com/eol_images/Entire_Site/201597/rs_300x300-151007061901-600.nicki-minaj-the-new-york-times-magazine.10715.jpg?downsize=600:*&crop=600:315;left,top"
  def avatar_url(_), do: "https://lelakisihat.com/wp-content/uploads/2016/09/avatar.jpg"

  defp generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(current_changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        current_changeset
    end
  end
end
