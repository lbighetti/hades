defmodule Hades.Accounts.Auth do
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [checkpw: 2]

  alias Hades.Repo
  alias Hades.Accounts.User

  def signup(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert
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