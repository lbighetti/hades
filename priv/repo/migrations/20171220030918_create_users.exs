defmodule Hades.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :password_hash, :string
      add :auth_token, :string
      add :is_admin, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
