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

  @invalid_attrs %{
    email: "some email",
    name: nil
  }

  @update_password_valid_attrs %{
    "password" => "n3wP455w0rd",
    "password_confirmation" => "n3wP455w0rd"
  }

  @update_password_invalid_attrs %{
    "password" => "n3wP455w0rd",
    "password_confirmation" => "d0ntm4tch"
  }

  setup do
    user = insert(:user)
    %{user: user}
  end

  describe "get_user!/1" do
    test "returns chosen resource with valid data", %{user: user} do
      assert {:ok, %User{} = _user} = Users.get_user!(user.id)
    end

    test "returns error when user is not found" do
      assert {:error, :not_found} = Users.get_user!(-1)
    end
  end

  describe "update_user/2" do
    test "updates user with valid data", %{user: user} do
      assert {:ok, %User{} = user} = Users.update_user(user, @valid_attrs)
      assert user.email == @valid_attrs.email
      assert user.name == @valid_attrs.name
      assert user.is_admin == @valid_attrs.is_admin
    end

    test "does not update user with invalid data", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
    end
  end

  describe "update_password/2" do
    test "updates password with valid data", %{user: user} do
      assert {:ok, %User{}} = Users.update_password(user, Map.merge(@update_password_valid_attrs, %{"old_password" => "test.112"}))
    end

    test "returns error when passwords don't match", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Users.update_password(user, Map.merge(@update_password_invalid_attrs, %{"old_password" => "test.112"}))
    end

    test "does not update password when new password data is not provided", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Users.update_password(user, %{"old_password" => user.password})
    end
  end

  describe "update_user_status/2" do
    test "updates user status with valid data", %{user: user} do
      assert {:ok, %User{} = user} = Users.update_user_status(user, %{is_active: false})
      assert user.is_active == false
    end

    test "does not update user status with invalid data", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Users.update_user_status(user, %{is_active: nil})
    end
  end
end