defmodule HadesWeb.MentoreeView do
  use HadesWeb, :view
  alias HadesWeb.MentoreeView

  def render("index.json", %{mentorees: mentorees}) do
    %{data: render_many(mentorees, MentoreeView, "mentoree.json")}
  end

  def render("show.json", %{mentoree: mentoree}) do
    %{data: render_one(mentoree, MentoreeView, "mentoree.json")}
  end

  def render("mentoree.json", %{mentoree: mentoree}) do
    %{id: mentoree.id,
      is_active: mentoree.is_active,
      is_minority: mentoree.is_minority}
  end
end
