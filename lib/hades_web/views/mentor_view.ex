defmodule HadesWeb.MentorView do
  use HadesWeb, :view
  alias HadesWeb.MentorView

  def render("index.json", %{mentors: mentors}) do
    %{data: render_many(mentors, MentorView, "mentor.json")}
  end

  def render("show.json", %{mentor: mentor}) do
    %{data: render_one(mentor, MentorView, "mentor.json")}
  end

  def render("mentor.json", %{mentor: mentor}) do
    %{id: mentor.id,
      is_active: mentor.is_active,
      max_mentorships: mentor.max_mentorships,
      skill_areas: mentor.skill_areas}
  end
end
