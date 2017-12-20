defmodule Hades.Accounts.AuthTest do
  use Hades.DataCase

  alias Hades.Accounts.User
  alias Hades.Accounts.Auth

  @valid_attrs %{
    email: "email@example.com",
    name: "some name",
    password: "some password"
  }

  @invalid_attrs %{
    email: nil,
    name: nil,
    password: nil
  }

  describe "signup/1" do
    test "creates a user with valid data" do
      assert {:ok, %User{} = _user} = Auth.signup(@valid_attrs)
    end

    test "returns error with invalid data" do
      assert {:error, %Ecto.Changeset{}} = Auth.signup(@invalid_attrs)
    end

    test "does not create user when email is too short" do
      assert {:error, %Ecto.Changeset{}} = Auth.signup(Map.put(@valid_attrs, :email, "a@.co"))
    end

    test "does not create user when email has invalid format" do
      assert {:error, %Ecto.Changeset{}} = Auth.signup(Map.put(@valid_attrs, :email, "email.com"))
    end
  end
end