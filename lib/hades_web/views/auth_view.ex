defmodule HadesWeb.AuthView do
  use HadesWeb, :view

  def render("auth.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      name: user.name,
      is_admin: user.is_admin}
  end
end