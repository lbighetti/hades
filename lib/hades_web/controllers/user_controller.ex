defmodule HadesWeb.UserController do
  use HadesWeb, :controller

  alias Hades.Accounts.{User, Users}

  action_fallback HadesWeb.FallbackController

  def get_user(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get_user!(id) do
      conn
      |> put_status(200)
      |> render("show.json", user: user)
    end
  end

  def update_password(conn, %{"user" => user_params}) do
    current_user = Hades.Guardian.Plug.current_resource(conn)
    with {:ok, %User{} = _user} <- Users.update_password(current_user, user_params) do
      conn
      |> render("update_password.json")
    end
  end
end