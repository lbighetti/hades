defmodule Hades.Mentorships.Mentor do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hades.Mentorships.Mentor

  @allowed_skill_areas ~w(Backend Frontend DevOps UX/UI Mobile Fullstack)
  @valid_attrs ~w(is_active max_mentorships skill_areas)a

  schema "mentors" do
    field :is_active, :boolean, default: false
    field :max_mentorships, :integer
    field :skill_areas, {:array, :string}
    belongs_to :user, Hades.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Mentor{} = mentor, attrs) do
    mentor
    |> cast(attrs, @valid_attrs)
    |> validate_required(@valid_attrs)
    |> validate_skill_areas
  end

  defp validate_skill_areas(changeset) do
    invalid_skill_areas =
      changeset
      |> get_field(:skill_areas)
      |> Enum.reject(fn(x) -> Enum.member?(@allowed_skill_areas, x) end)

    if Enum.empty? invalid_skill_areas do
      changeset
    else
      add_error(changeset, :skill_areas, "Invalid skill area(s)")
    end
  end
end
