defmodule Hades.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Hades.Repo

  def user_factory do
    %Hades.Accounts.User{
      name: "Jane Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "test.112",
      password_hash: "$2b$12$HaSA5EZeWPmBzynzOU.7cutROZ.5wRqM/zJwu3kWACWUZbZ7JdKwi",
      is_admin: false
    }
  end

  def mentoree_factory do
    %Hades.Mentorships.Mentoree{
      is_active: true,
      is_minority: false,
      user: build(:user),
    }
  end
end