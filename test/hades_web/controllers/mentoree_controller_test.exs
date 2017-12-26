defmodule HadesWeb.MentoreeControllerTest do
  use HadesWeb.ConnCase

  alias Hades.Mentorships
  alias Hades.Mentorships.Mentoree
  alias Hades.FakeData
  alias Hades.Accounts.Auth

  @create_attrs %{is_active: true, is_minority: true}
  @update_attrs %{is_active: false, is_minority: false}
  @invalid_attrs %{is_active: nil, is_minority: nil}

  def fixture(:mentoree) do
    {:ok, mentoree} = Mentorships.create_mentoree(@create_attrs)
    mentoree
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{email: FakeData.email, name: "some name", is_admin: FakeData.boolean, password: "S0m3p4ssW0rd"})
      |> Auth.signup
    user
  end

  setup %{conn: conn} do
    user = user_fixture()
    {:ok, token, _claims} = Hades.Guardian.encode_and_sign(user)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user, token: token}
  end

  describe "index" do
    test "lists all mentorees", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = get conn, mentoree_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create mentoree" do
    test "renders mentoree when data is valid", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = post conn, mentoree_path(conn, :create), mentoree: @create_attrs
      body = json_response(conn, 201)
      assert body["data"]["is_active"] == true
      assert body["data"]["is_minority"] == true
    end

    test "renders errors when data is invalid", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = post conn, mentoree_path(conn, :create), mentoree: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update mentoree" do
    setup [:create_mentoree]

    test "renders mentoree when data is valid", %{conn: conn, mentoree: %Mentoree{id: id} = mentoree, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = put conn, mentoree_path(conn, :update, mentoree), mentoree: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]
      body = json_response(conn, 200)
      assert body["data"]["is_active"] == false
      assert body["data"]["is_minority"] == false
    end

    test "renders errors when data is invalid", %{conn: conn, mentoree: mentoree, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = put conn, mentoree_path(conn, :update, mentoree), mentoree: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_mentoree(_) do
    mentoree = fixture(:mentoree)
    {:ok, mentoree: mentoree}
  end
end
