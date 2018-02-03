defmodule Hades.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :mentoree_id, references(:mentorees, on_delete: :nothing)
      add :requested_at, :naive_datetime, default: fragment("now()")
      add :status, :integer, default: 2
      add :skill_area, :integer
      add :mentoree_level, :integer

      timestamps()
    end

    create index(:requests, [:mentoree_id])
  end
end
