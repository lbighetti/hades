defmodule Hades.Repo.Migrations.CreateMentors do
  use Ecto.Migration

  def change do
    create table(:mentors) do
      add :is_active, :boolean, default: false, null: false
      add :max_mentorships, :integer
      add :skill_areas, {:array, :string}
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:mentors, [:user_id])
  end
end
