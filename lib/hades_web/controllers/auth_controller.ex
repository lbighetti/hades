defmodule HadesWeb.AuthController do
  use HadesWeb, :controller

  alias Hades.Accounts.Auth
  alias Hades.Accounts.User

  def signup(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.signup(user_params) do
      conn
      |> put_status(:created)
      |> render("auth.json", user: user)
    end
  end
end