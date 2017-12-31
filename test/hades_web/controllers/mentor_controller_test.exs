defmodule HadesWeb.MentorControllerTest do
  use HadesWeb.ConnCase

  alias Hades.Mentorships
  alias Hades.Mentorships.Mentor
  alias Hades.FakeData
  alias Hades.Accounts.Auth

  @create_attrs %{is_active: true, max_mentorships: 2, skill_areas: ["Backend", "Frontend"]}
  @update_attrs %{is_active: false, max_mentorships: 3, skill_areas: ["Backend", "Frontend", "DevOps"]}
  @invalid_attrs %{is_active: nil, max_mentorships: nil, skill_areas: ["Bad input","Not a thing"]}
  @invalid_skill_areas_attrs %{is_active: false, max_mentorships: 3, skill_areas: ["Bad", "Skills"]}

  def fixture(:mentor) do
    {:ok, mentor} = Mentorships.create_mentor(@create_attrs)
    mentor
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{email: FakeData.email, name: "some name", is_admin: FakeData.boolean, password: "S0m3p4ssW0rd"})
      |> Auth.sign_up
    user
  end

  setup %{conn: conn} do
    user = user_fixture()
    {:ok, token, _claims} = Hades.Guardian.encode_and_sign(user)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user, token: token}
  end

  describe "index" do
    test "lists all mentors", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = get conn, mentor_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create mentor" do
    test "renders mentor when data is valid", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = post conn, mentor_path(conn, :create), mentor: @create_attrs
      body = json_response(conn, 201)
      assert body["data"]["is_active"] == true
      assert body["data"]["max_mentorships"] == 2
      assert body["data"]["skill_areas"] == ["Backend", "Frontend"]
    end

    test "renders errors when data is invalid", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = post conn, mentor_path(conn, :create), mentor: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders errors when skill areas is invalid", %{conn: conn, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = post conn, mentor_path(conn, :create), mentor: @invalid_skill_areas_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update mentor" do
    setup [:create_mentor]

    test "renders mentor when data is valid", %{conn: conn, mentor: %Mentor{id: id} = mentor, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = put conn, mentor_path(conn, :update, mentor), mentor: @update_attrs
      body = json_response(conn, 200)
      assert body["data"]["id"] == id
      assert body["data"]["is_active"] == false
      assert body["data"]["max_mentorships"] == 3
      assert body["data"]["skill_areas"] == ["Backend", "Frontend", "DevOps"]
    end

    test "renders errors when data is invalid", %{conn: conn, mentor: mentor, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = put conn, mentor_path(conn, :update, mentor), mentor: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders errors when skill areas is invalid", %{conn: conn, mentor: mentor, token: token} do
      conn = conn |> put_req_header("authorization", "Bearer #{token}")
      conn = put conn, mentor_path(conn, :update, mentor), mentor: @invalid_skill_areas_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_mentor(_) do
    mentor = fixture(:mentor)
    {:ok, mentor: mentor}
  end
end
