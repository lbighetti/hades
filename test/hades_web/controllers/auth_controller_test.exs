defmodule HadesWeb.AuthControllerTest do
  use HadesWeb.ConnCase

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

  describe "signup/2" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, auth_path(conn, :signup), user: @valid_attrs
      assert json_response(conn, 201)["data"] != %{}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, auth_path(conn, :signup), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end