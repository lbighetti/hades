defmodule HadesWeb.AuthView do
  use HadesWeb, :view

  alias HadesWeb.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("session.json", %{user: user, token: token, exp: exp}) do
    %{
      data: render_one(user, UserView, "user.json"),
      meta: %{token: token, exp: exp}
    }
  end

  def render("bad_request.json", _params) do
    %{errors: %{detail: "Bad request"}}
  end
end