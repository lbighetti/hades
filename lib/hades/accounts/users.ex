defmodule Hades.Accounts.Users do
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

  def delete_user(user), do: Repo.delete(user)
end