defmodule Hades.Accounts.Users do
  alias Hades.Repo
  alias Hades.Accounts.User

  def get_user!(id), do: Repo.get!(User, id)

  def update_user(user, attrs) do
    user
    |> User.changeset_update(attrs)
    |> Repo.update
  end
end