defmodule HadesWeb.AuthView do
  use HadesWeb, :view

  alias HadesWeb.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("session.json", %{token: token, exp: exp}) do
    %{
      meta: %{token: token, exp: exp}
    }
  end
end