defmodule Hades.Accounts.Validation do
  import Ecto.Changeset

  def validate_email(changeset) do
    changeset
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/\A[^@\s]+@[^@\s]+\z/)
    |> validate_length(:email, min: 6, max: 255)
  end
end