defmodule HadesWeb.HelloControllerTest do
  use HadesWeb.ConnCase

  test "/hello endpoint works", %{conn: conn} do

    response = conn
    |> get(hello_path(conn, :hello))
    |> response(200)

    assert response == "Hi There! Welcome to Hades!"
  end
end