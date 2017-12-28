defmodule HadesWeb.AuthController do
  use HadesWeb, :controller

  alias Hades.Accounts.{User, Auth}

  action_fallback HadesWeb.FallbackController

  def signup(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.signup(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def signin(conn, %{"user" => user_params}) do
    with {:ok, token, claims, user} <- Auth.signin(user_params["email"], user_params["password"]) do
      conn
      |> put_status(:created)
      |> render("session.json", user: user, token: token, exp: claims["exp"])
    end
  end
end