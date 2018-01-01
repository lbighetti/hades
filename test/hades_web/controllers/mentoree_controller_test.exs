defmodule HadesWeb.MentoreeControllerTest do
  use HadesWeb.ConnCase

  import Hades.Factory

  alias Hades.Mentorships.Mentoree

  @create_attrs %{is_active: true, is_minority: true}
  @update_attrs %{is_active: false, is_minority: false}
  @invalid_attrs %{is_active: nil, is_minority: nil}

  setup %{conn: conn} do
    user = insert(:user)
    mentoree = insert(:mentoree, user: user)
    {:ok, token, _claims} = Hades.Guardian.encode_and_sign(user)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user, mentoree: mentoree, token: token}
  end

  describe "index" do
    test "lists all mentorees", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = get conn, mentoree_path(conn, :index)
      assert json_response(conn, 200)["data"] != []
    end
  end

  describe "create mentoree" do
    test "renders mentoree when data is valid", %{conn: conn, token: token, user: user} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = post conn, mentoree_path(conn, :create), mentoree: Map.merge(@create_attrs, %{user_id: user.id})
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
end
