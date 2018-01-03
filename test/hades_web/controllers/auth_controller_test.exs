defmodule HadesWeb.AuthControllerTest do
  use HadesWeb.ConnCase

  import Hades.Factory

  alias Hades.FakeData

  @valid_attrs %{
    email: FakeData.email,
    name: "some name",
    is_admin: FakeData.boolean,
    password: "S0m3p4ssW0rd"
  }

  @invalid_attrs %{
    email: nil,
    name: nil,
    is_admin: nil,
    password: nil
  }

  setup %{conn: conn} do
    user = insert(:user)
    {:ok, token, _claims} = Hades.Guardian.encode_and_sign(user)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user, token: token}
  end

  describe "sign_up/2" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, auth_path(conn, :sign_up), user: @valid_attrs
      body = json_response(conn, 201)
      assert body["data"]["email"] == @valid_attrs.email
      assert body["data"]["name"] == @valid_attrs.name
      assert body["data"]["is_admin"] == @valid_attrs.is_admin
      refute body["data"]["password"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, auth_path(conn, :sign_up), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "sign_in/2" do
    test "authenticates user with valid credentials", %{conn: conn, user: user} do
      conn = post conn, auth_path(conn, :sign_in), user: %{ email: user.email, password: user.password }
      body = json_response(conn, 201)
      assert body["data"]["email"] == user.email
      assert body["data"]["name"] == user.name
      assert body["data"]["is_admin"] == user.is_admin
      assert body["meta"]["token"]
      assert body["meta"]["exp"]
    end

    test "returns bad request when no data is provided", %{conn: conn} do
      conn = post conn, auth_path(conn, :sign_in)
      body = json_response(conn, 400)
      assert body == %{"errors" => %{"detail" => "Bad request"}}
    end

    test "returns unauthorized when password is not valid", %{conn: conn, user: user} do
      conn = post conn, auth_path(conn, :sign_in), user: %{ email: user.email, password: "Wr0ngP455" }
      body = json_response(conn, 401)
      assert body == %{"errors" => %{"detail" => "Unauthorized"}}
    end

    test "returns not found when email is not valid", %{conn: conn} do
      conn = post conn, auth_path(conn, :sign_in), user: %{ email: FakeData.email, password: "S0m3p4ssW0rd" }
      body = json_response(conn, 404)
      assert body == %{"errors" => %{"detail" => "Page not found"}}
    end
  end

  describe "sign_out/2" do
    test "revoke current user's token", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = delete conn, auth_path(conn, :sign_out)
      body = json_response(conn, 200)
      assert body["message"] == "You have signed out successfully!"
    end
  end
end