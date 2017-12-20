defmodule Hades.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :auth_token, :string
    field :is_admin, :boolean

    timestamps()
  end

  @required_fields ~w(email name password)a
  @optional_fields ~w(is_admin)a

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/\A[^@\s]+@[^@\s]+\z/)
    |> validate_length(:email, min: 6, max: 255)
  end
end