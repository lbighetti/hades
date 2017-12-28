defmodule Hades.Accounts.Auth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias Hades.Repo
  alias Hades.Accounts.User

  def signup(attrs \\ %{}) do
    changeset = User.changeset(%User{}, attrs)
    case Repo.insert(changeset) do
      {:ok, user} ->
        {:ok, user}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def signin(email, password) do
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

  def reset_password(user, attrs) do
    changeset = User.changeset_update_password(user, attrs)

    if checkpw(attrs[:old_password], user.password_hash) do
      case Repo.update(changeset) do
        {:ok, user} ->
          {:ok, user}
        {:error, changeset} ->
          {:error, changeset}
      end
    else
      {:error, :invalid_password}
    end
  end
end