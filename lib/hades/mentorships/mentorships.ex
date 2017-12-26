defmodule Hades.Mentorships do
  @moduledoc """
  The Mentorships context.
  """

  import Ecto.Query, warn: false
  alias Hades.Repo

  alias Hades.Mentorships.Mentor

  @doc """
  Returns the list of mentors.

  ## Examples

      iex> list_mentors()
      [%Mentor{}, ...]

  """
  def list_mentors do
    Repo.all(Mentor)
  end

  @doc """
  Gets a single mentor.

  Raises `Ecto.NoResultsError` if the Mentor does not exist.

  ## Examples

      iex> get_mentor!(123)
      %Mentor{}

      iex> get_mentor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mentor!(id), do: Repo.get!(Mentor, id)

  @doc """
  Creates a mentor.

  ## Examples

      iex> create_mentor(%{field: value})
      {:ok, %Mentor{}}

      iex> create_mentor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mentor(attrs \\ %{}) do
    %Mentor{}
    |> Mentor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mentor.

  ## Examples

      iex> update_mentor(mentor, %{field: new_value})
      {:ok, %Mentor{}}

      iex> update_mentor(mentor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mentor(%Mentor{} = mentor, attrs) do
    mentor
    |> Mentor.changeset(attrs)
    |> Repo.update()
  end

  alias Hades.Mentorships.Mentoree

  @doc """
  Returns the list of mentorees.

  ## Examples

      iex> list_mentorees()
      [%Mentoree{}, ...]

  """
  def list_mentorees do
    Repo.all(Mentoree)
  end

  @doc """
  Gets a single mentoree.

  Raises `Ecto.NoResultsError` if the Mentoree does not exist.

  ## Examples

      iex> get_mentoree!(123)
      %Mentoree{}

      iex> get_mentoree!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mentoree!(id), do: Repo.get!(Mentoree, id)

  @doc """
  Creates a mentoree.

  ## Examples

      iex> create_mentoree(%{field: value})
      {:ok, %Mentoree{}}

      iex> create_mentoree(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mentoree(attrs \\ %{}) do
    %Mentoree{}
    |> Mentoree.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mentoree.

  ## Examples

      iex> update_mentoree(mentoree, %{field: new_value})
      {:ok, %Mentoree{}}

      iex> update_mentoree(mentoree, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mentoree(%Mentoree{} = mentoree, attrs) do
    mentoree
    |> Mentoree.changeset(attrs)
    |> Repo.update()
  end
end
