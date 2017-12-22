defmodule Hades.Accounts.AuthTest do
  use Hades.DataCase

  alias Hades.FakeData
  alias Hades.Accounts.User
  alias Hades.Accounts.Auth

  @valid_attrs %{
    email: FakeData.email,
    name: FakeData.term(20),
    is_admin: FakeData.boolean,
    password: FakeData.term(20)
  }

  @invalid_attrs %{
    email: nil,
    name: nil,
    is_admin: nil,
    password: nil
  }

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

    test "does not create user when email is too short" do
      assert {:error, %Ecto.Changeset{}} = Auth.signup(Map.put(@valid_attrs, :email, FakeData.term(1) <> "@" <> FakeData.term(3)))
    end

    test "does not create user when email has invalid format" do
      assert {:error, %Ecto.Changeset{}} = Auth.signup(Map.put(@valid_attrs, :email, FakeData.term(10)))
    end
  end
end