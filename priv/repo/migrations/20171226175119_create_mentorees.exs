defmodule Hades.Repo.Migrations.CreateMentorees do
  use Ecto.Migration

  def change do
    create table(:mentorees) do
      add :is_active, :boolean, default: false, null: false
      add :is_minority, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:mentorees, [:user_id])
  end
end
