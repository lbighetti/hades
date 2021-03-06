defmodule Hades.Accounts.AuthTest do
  use Hades.DataCase

  import Hades.Factory

  alias Hades.FakeData
  alias Hades.Accounts.{Auth, User}

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

  setup do
    user = insert(:user)
    user2 = insert(:user)
    %{user: user, user2: user2}
  end

  describe "sign_up/1" do
    test "creates a user with valid data" do
      assert {:ok, %User{} = user} = Auth.sign_up(@valid_attrs)
      assert user.email == @valid_attrs.email
      assert user.name == @valid_attrs.name
      assert user.is_admin == @valid_attrs.is_admin
    end

    test "returns error with invalid data" do
      assert {:error, %Ecto.Changeset{}} = Auth.sign_up(@invalid_attrs)
    end

    test "does not create user when no data is provided" do
      assert {:error, %Ecto.Changeset{}} = Auth.sign_up()
    end

    test "does not create user when email is too short" do
      assert {:error, %Ecto.Changeset{}} = Auth.sign_up(Map.put(@valid_attrs, :email, "a@.co"))
    end

    test "does not create user when email has invalid format" do
      assert {:error, %Ecto.Changeset{}} = Auth.sign_up(Map.put(@valid_attrs, :email, "example.com"))
    end

    test "does not create user when password is too short" do
      assert {:error, %Ecto.Changeset{}} = Auth.sign_up(Map.put(@valid_attrs, :password, "S0m3p4s"))
    end

    test "does not create user when password has an invalid format" do
      assert {:error, %Ecto.Changeset{}} = Auth.sign_up(Map.put(@valid_attrs, :password, "12345678"))
    end
  end

  describe "sign_in/2" do
    test "authenticates user whith valid credentials", %{user: user} do
      assert {:ok, _token, _claims, user} = Auth.sign_in(user.email, user.password)
      assert user.email == user.email
      assert user.name == user.name
      assert user.is_admin == user.is_admin
    end

    test "returns unauthorized when password is not valid", %{user: user} do
      assert {:error, :unauthorized} = Auth.sign_in(user.email, "Wr0ngP455")
    end

    test "returns not found when email is not valid" do
      assert {:error, :not_found} = Auth.sign_in(FakeData.email, "S0m3p4ssW0rd")
    end
  end
end