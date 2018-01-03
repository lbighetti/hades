defmodule Hades.Accounts.UsersTest do
  use Hades.DataCase

  import Hades.Factory

  alias Hades.FakeData
  alias Hades.Accounts.{User, Users}

  @valid_attrs %{
    email: FakeData.email,
    name: "some name",
    is_admin: FakeData.boolean,
  }

  setup do
    user = insert(:user)
    %{user: user}
  end

  describe "get_user!/1" do
    test "returns chosen resource with valid data", %{user: user} do
      assert {:ok, %User{} = _user} = Users.get_user!(user.id)
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