defmodule HadesWeb.UserView do
  use HadesWeb, :view

  alias HadesWeb.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, email: user.email, name: user.name, is_admin: user.is_admin}
  end

  def render("user_status.json", %{user: user}) do
    if user.is_active do
      %{message: "User is active"}
    else
      %{message: "User is inactive"}
    end
  end
end