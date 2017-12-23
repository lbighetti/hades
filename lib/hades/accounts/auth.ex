defmodule Hades.Accounts.Auth do
  import Ecto.Changeset

  alias Hades.Repo
  alias Hades.Accounts.User

  def signup(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert
  end

  def put_authentication_token(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :auth_token, SecureRandom.urlsafe_base64(32))
      _ ->
        changeset
    end
  end
end