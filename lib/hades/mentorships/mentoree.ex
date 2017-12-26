defmodule Hades.Mentorships.Mentoree do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hades.Mentorships.Mentoree

  @valid_attrs ~w(is_active is_minority)a

  schema "mentorees" do
    field :is_active, :boolean, default: false
    field :is_minority, :boolean, default: false
    belongs_to :user, Hades.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Mentoree{} = mentoree, attrs) do
    mentoree
    |> cast(attrs, @valid_attrs)
    |> validate_required(@valid_attrs)
  end
end
