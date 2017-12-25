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
end