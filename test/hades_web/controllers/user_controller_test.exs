defmodule HadesWeb.UserControllerTest do
  use HadesWeb.ConnCase

  import Hades.Factory

  alias Hades.FakeData

  setup %{conn: conn} do
    user = insert(:user, email: FakeData.email, is_admin: FakeData.boolean)
    {:ok, token, _claims} = Hades.Guardian.encode_and_sign(user)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user, token: token}
  end

  describe "get_user/2" do
    test "renders user when data is valid", %{conn: conn, user: user, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = get conn, user_path(conn, :get_user, user.id)
      body = json_response(conn, 200)
      assert body["data"]["email"] == user.email
      assert body["data"]["name"] == user.name
      assert body["data"]["is_admin"] == user.is_admin
      refute body["data"]["password"]
    end
  end

  describe "update_user_status/2" do
    test "renders user status with valid data", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = put conn, user_path(conn, :update_user_status), user: %{is_active: false}
      assert json_response(conn, 200) == %{"message" => "User is inactive"}
    end
  end
end