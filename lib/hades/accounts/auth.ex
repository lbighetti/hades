defmodule Hades.Accounts.Auth do
  import Ecto.{Query, Changeset}, warn: false

  alias Hades.Repo
  alias Hades.Accounts.User

  def signup(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert
  end
end