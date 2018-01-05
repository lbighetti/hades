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

  describe "update_user/2" do
    test "updates user with valid data", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = put conn, user_path(conn, :update_user), user: %{name: "Jane Doe", email: "janedoe@example.com", is_admin: false }
      body = json_response(conn, 200)
      assert body["data"]["email"] == "janedoe@example.com"
      assert body["data"]["name"] == "Jane Doe"
      assert body["data"]["is_admin"] == false
      refute body["data"]["password"]
    end

    test "does not updates user with invalid data", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = put conn, user_path(conn, :update_user), user: %{name: nil, email: "some_email" }
      assert json_response(conn, 422) == %{"errors" => %{"email" => ["has invalid format"]}}
    end
  end

  describe "update_password/2" do
    test "updates password when data is valid", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = put conn, user_path(conn, :update_password), user: %{old_password: "test.112", password: "N3wp455W0rd",
        password_confirmation: "N3wp455W0rd"}
      assert json_response(conn, 200) == %{"message" => "Password updated successfully!"}
    end

    test "does not updates password when passwords don't match", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = put conn, user_path(conn, :update_password), user: %{old_password: "test.112", password: "N3wp455",
        password_confirmation: "N3wp455W0rd"}
      assert json_response(conn, 422) == %{"errors" => %{"password_confirmation" => ["Passwords don't match"]}}
    end
  end
end