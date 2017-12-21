defmodule HadesWeb.MentorController do
  use HadesWeb, :controller

  alias Hades.Mentorships
  alias Hades.Mentorships.Mentor

  action_fallback HadesWeb.FallbackController

  def index(conn, _params) do
    mentors = Mentorships.list_mentors()
    render(conn, "index.json", mentors: mentors)
  end

  def create(conn, %{"mentor" => mentor_params}) do
    with {:ok, %Mentor{} = mentor} <- Mentorships.create_mentor(mentor_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", mentor_path(conn, :show, mentor))
      |> render("show.json", mentor: mentor)
    end
  end

  def show(conn, %{"id" => id}) do
    mentor = Mentorships.get_mentor!(id)
    render(conn, "show.json", mentor: mentor)
  end

  def update(conn, %{"id" => id, "mentor" => mentor_params}) do
    mentor = Mentorships.get_mentor!(id)

    with {:ok, %Mentor{} = mentor} <- Mentorships.update_mentor(mentor, mentor_params) do
      render(conn, "show.json", mentor: mentor)
    end
  end
end
