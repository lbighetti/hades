defmodule Hades.Accounts.AuthTest do
  use Hades.DataCase

  alias Hades.FakeData
  alias Hades.Accounts.User
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

  @reset_password_valid_attrs %{
    old_password: "S0m3p4ssW0rd",
    password: "n3wP455w0rd",
    password_confirmation: "n3wP455w0rd"
  }

  @reset_password_invalid_attrs %{
    old_password: "S0m3p4ssW0rd",
    password: "n3wP455w0rd",
    password_confirmation: "d0ntm4tch"
  }

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(Map.merge(@valid_attrs, %{email: FakeData.email, password: "S0m3p4ssW0rd"}))
      |> Auth.signup
    user
  end

  setup do
    user = user_fixture()
    %{user: user}
  end

  describe "signup/1" do
    test "creates a user with valid data" do
      assert {:ok, %User{} = user} = Auth.signup(@valid_attrs)
      assert user.email == @valid_attrs.email
      assert user.name == @valid_attrs.name
      assert user.is_admin == @valid_attrs.is_admin
    end

    test "returns error with invalid data" do
      assert {:error, %Ecto.Changeset{}} = Auth.signup(@invalid_attrs)
    end

    test "does not create user when no data is provided" do
      assert {:error, %Ecto.Changeset{}} = Auth.signup()
    end

    test "does not create user when email is too short" do
      assert {:error, %Ecto.Changeset{}} = Auth.signup(Map.put(@valid_attrs, :email, "a@.co"))
    end

    test "does not create user when email has invalid format" do
      assert {:error, %Ecto.Changeset{}} = Auth.signup(Map.put(@valid_attrs, :email, "example.com"))
    end

    test "does not create user when password is too short" do
      assert {:error, %Ecto.Changeset{}} = Auth.signup(Map.put(@valid_attrs, :password, "S0m3p4s"))
    end

    test "does not create user when password has an invalid format" do
      assert {:error, %Ecto.Changeset{}} = Auth.signup(Map.put(@valid_attrs, :password, "12345678"))
    end
  end

  describe "reset_password/2" do
    test "resets password with valid data", %{user: user} do
      assert {:ok, %User{}} = Auth.reset_password(user, @reset_password_valid_attrs)
    end

    test "returns error when passwords don't match", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Auth.reset_password(user, @reset_password_invalid_attrs)
    end

    test "does not reset password when new password data is not provided", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Auth.reset_password(user, %{old_password: "S0m3p4ssW0rd"})
    end
  end
end