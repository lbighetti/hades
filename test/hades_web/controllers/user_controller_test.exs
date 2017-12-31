defmodule HadesWeb.UserControllerTest do
  use HadesWeb.ConnCase

  alias Hades.FakeData
  alias Hades.Accounts.Auth

  @valid_attrs %{
    email: FakeData.email,
    name: "some name",
    is_admin: FakeData.boolean
  }

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(Map.merge(@valid_attrs, %{password: "S0m3p4ssW0rd"}))
      |> Auth.sign_up
    user
  end

  setup %{conn: conn} do
    user = user_fixture()
    {:ok, token, _claims} = Hades.Guardian.encode_and_sign(user)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user, token: token}
  end

  describe "get_user/2" do
    test "renders user when data is valid", %{conn: conn, user: user, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = get conn, user_path(conn, :get_user, user.id)
      body = json_response(conn, 200)
      assert body["data"]["email"] == @valid_attrs.email
      assert body["data"]["name"] == @valid_attrs.name
      assert body["data"]["is_admin"] == @valid_attrs.is_admin
      refute body["data"]["password"]
    end
  end
end