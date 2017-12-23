defmodule Hades.Accounts.Validation do
  import Ecto.Changeset

  def validate_email(changeset) do
    changeset
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/\A[^@\s]+@[^@\s]+\z/)
    |> validate_length(:email, min: 6, max: 255)
  end

  @doc """
    Password must be at least 8 characters, no more than 20 characters, and
    must include at least one upper case letter, one lower case letter, and
    one numeric digit.
  """
  def validate_password(changeset) do
    changeset
    |> validate_format(:password, ~r/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,20}$/)
  end
end