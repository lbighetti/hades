defmodule Hades.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Hades.Accounts.{Validation, Encryption}

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :is_admin, :boolean
    has_one :mentor, Hades.Mentorships.Mentor
    has_one :mentoree, Hades.Mentorships.Mentoree

    timestamps()
  end

  @required_fields ~w(email name password)a
  @optional_fields ~w(is_admin)a

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> Validation.validate_email
    |> Validation.validate_password
    |> Encryption.hash_password
  end

  def changeset_update_user(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :is_admin])
    |> Validation.validate_email
  end

  def changeset_update_password(user, attrs) do
    user
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_required([:password, :password_confirmation])
    |> Encryption.change_password
  end
end