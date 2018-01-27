defmodule Hades.Mentorships.Request do
  use Ecto.Schema

  import Ecto.Changeset
  import Hades.Helpers.Enum

  alias Hades.Mentorships.Request

  enum "status" do
    %{
      active: 1,
      inactive: 2
    }
  end

  enum "skill_area" do
    %{
      backend: 1,
      frontend: 2,
      dev_ops: 3,
      ux_ui: 4,
      mobile: 5,
      fullstack: 6
    }
  end

  enum "mentoree_level" do
    %{
      basic: 1,
      intermediate: 2,
      advanced: 3
    }
  end

  schema "requests" do
    field :requested_at, :naive_datetime
    field :status, :integer
    field :skill_area, :integer
    field :mentoree_level, :integer

    belongs_to :mentoree, Hades.Mentorships.Mentoree

    timestamps()
  end

  @required_fields ~w(mentoree_id skill_area)a
  @optioal_fields ~w(requested_at status mentoree_level)

  @doc false
  def changeset(%Request{} = request, attrs) do
    request
    |> cast(attrs, @required_fields ++ @optioal_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:mentoree_id)
  end
end