defmodule HadesWeb.AuthController do
  use HadesWeb, :controller

  alias Hades.Accounts.{User, Auth}

  action_fallback HadesWeb.FallbackController

  def sign_up(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.sign_up(user_params) do
      conn
      |> put_status(:created)
      |> render("current_user.json", user: user)
    end
  end

  def sign_in(conn, %{"user" => user_params}) do
    with {:ok, token, claims, user} <- Auth.sign_in(user_params["email"], user_params["password"]) do
      conn
      |> put_status(:created)
      |> render("sign_in.json", user: user, token: token, exp: claims["exp"])
    end
  end
  def sign_in(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> render("bad_request.json")
  end

  def sign_out(conn, _params) do
    token = Hades.Guardian.Plug.current_token(conn)
    Hades.Guardian.revoke(token)
    conn
    |> render("sign_out.json")
  end
end