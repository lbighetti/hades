defmodule Hades.Accounts.Users do
  import Comeonin.Bcrypt, only: [checkpw: 2]

  alias Hades.Repo
  alias Hades.Accounts.User

  def get_user!(id) do
    case Repo.get(User, id) do
      %User{} = user ->
        {:ok, user}
      nil ->
        {:error, :not_found}
    end
  end

  def update_user(user, attrs) do
    user
    |> User.changeset_update_user(attrs)
    |> Repo.update
  end

  def update_password(user, attrs) do
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

  def update_user_status(user, attrs) do
    changeset = User.changeset_update_user_status(user, attrs)
    case Repo.update(changeset) do
      {:ok, user} ->
        {:ok, user}
      {:error, changeset} ->
        {:error, changeset}
    end
  end
end