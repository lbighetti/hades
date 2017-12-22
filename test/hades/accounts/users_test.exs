defmodule Hades.Accounts.UsersTest do
  use Hades.DataCase

  alias Hades.FakeData
  alias Hades.Accounts.Auth
  alias Hades.Accounts.User
  alias Hades.Accounts.Users

  @valid_attrs %{
    email: FakeData.email,
    name: FakeData.term(20),
    is_admin: FakeData.boolean
  }

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(Map.merge(@valid_attrs, %{password: "some password"}))
      |> Auth.signup
    user
  end

  setup do
    user = user_fixture()
    %{user: user}
  end

  describe "get_user!/1" do
    test "returns chosen resource with valid data", %{user: user} do
      assert %User{} = Users.get_user!(user.id)
    end
  end

  describe "update_user/2" do
    test "updates user with valid data", %{user: user} do
      assert {:ok, %User{} = user} = Users.update_user(user, @valid_attrs)
      assert user.email == @valid_attrs.email
      assert user.name == @valid_attrs.name
      assert user.is_admin == @valid_attrs.is_admin
    end
  end

  describe "delete_user/1" do
    test "deletes user with valid data", %{user: user} do
      assert {:ok, %User{} = _user} = Users.delete_user(user)
    end
  end
end