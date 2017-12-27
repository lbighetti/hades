defmodule Hades.Repo.Migrations.RemoveAuthTokenFromUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :auth_token
    end
  end
end
