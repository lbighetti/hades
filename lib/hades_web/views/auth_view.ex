defmodule HadesWeb.AuthView do
  use HadesWeb, :view

  alias HadesWeb.UserView

  def render("current_user.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("sign_in.json", %{user: user, token: token, exp: exp}) do
    %{data: render_one(user, UserView, "user.json"),
      meta: %{token: token, exp: exp}}
  end

  def render("sign_out.json", _params) do
    %{message: "You have signed out successfully!"}
  end

  def render("bad_request.json", _params) do
    %{errors: %{detail: "Bad request"}}
  end

  def render("update_password.json", _params) do
    %{message: "Password updated successfully!"}
  end
end