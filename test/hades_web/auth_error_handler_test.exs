defmodule HadesWeb.AuthErrorHandlerTest do
  use HadesWeb.ConnCase

  describe "auth_error" do
    test "sends 401 resp with {message: <type>} json as body", %{conn: conn} do
      conn = HadesWeb.AuthErrorHandler.auth_error(conn, {:unauthorized, nil}, nil)

      assert conn.status == 401
      assert conn.resp_body == Poison.encode!(%{message: "unauthorized"})
    end
  end
end