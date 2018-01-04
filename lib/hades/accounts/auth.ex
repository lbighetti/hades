defmodule Hades.Accounts.Auth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias Hades.Repo
  alias Hades.Accounts.User

  def sign_up(attrs \\ %{}) do
    changeset = User.changeset(%User{}, attrs)
    case Repo.insert(changeset) do
      {:ok, user} ->
        {:ok, user}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def sign_in(email, password) do
    user = Repo.get_by(User, email: email)
    cond do
      user && checkpw(password, user.password_hash) ->
        {:ok, token, claims} = Hades.Guardian.encode_and_sign(user)
        {:ok, token, claims, user}
      user ->
        {:error, :unauthorized}
      true ->
        dummy_checkpw()
        {:error, :not_found}
    end
  end
end