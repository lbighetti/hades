defmodule Hades.Mentorships.Mentor do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hades.Mentorships.Mentor


  schema "mentors" do
    field :is_active, :boolean, default: false
    field :max_mentorships, :integer
    field :skill_areas, {:array, :string}
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Mentor{} = mentor, attrs) do
    mentor
    |> cast(attrs, [:is_active, :max_mentorships, :skill_areas])
    |> validate_required([:is_active, :max_mentorships, :skill_areas])
  end
end
