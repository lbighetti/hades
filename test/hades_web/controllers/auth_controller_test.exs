defmodule HadesWeb.AuthControllerTest do
  use HadesWeb.ConnCase

  alias Hades.FakeData
  alias Hades.Accounts.Auth

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

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{email: "john.doe@example.com", name: "some name", is_admin: FakeData.boolean, password: "S0m3p4ssW0rd"})
      |> Auth.signup
    user
  end

  setup %{conn: conn} do
    user_fixture()
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "signup/2" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, auth_path(conn, :signup), user: @valid_attrs
      body = json_response(conn, 201)
      assert body["data"]["email"] == @valid_attrs.email
      assert body["data"]["name"] == @valid_attrs.name
      assert body["data"]["is_admin"] == @valid_attrs.is_admin
      refute body["data"]["password"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, auth_path(conn, :signup), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "signin/2" do
    test "authenticates user with valid credentials", %{conn: conn} do
      conn = post conn, auth_path(conn, :signin), user: %{ email: "john.doe@example.com", password: "S0m3p4ssW0rd" }
      body = json_response(conn, 201)
      assert body["meta"]["token"]
      assert body["meta"]["exp"]
    end

    test "returns unauthorized when password is not valid", %{conn: conn} do
      conn = post conn, auth_path(conn, :signin), user: %{ email: "john.doe@example.com", password: "Wr0ngP455" }
      body = json_response(conn, 401)
      assert body == %{"errors" => %{"detail" => "Unauthorized"}}
    end

    test "returns not found when email is not valid", %{conn: conn} do
      conn = post conn, auth_path(conn, :signin), user: %{ email: FakeData.email, password: "S0m3p4ssW0rd" }
      body = json_response(conn, 404)
      assert body == %{"errors" => %{"detail" => "Page not found"}}
    end
  end
end