defmodule Hades.Guardian do
  use Guardian, otp_app: :hades

  alias Hades.Accounts.User
  alias Hades.Accounts.Users

  def subject_for_token(%User{} = user, _claims) do
    {:ok, to_string(user.id)}
  end
  def subject_for_token(_, _) do
    {:error, :unknown_resource}
  end

  def resource_from_claims(claims) do
    user = claims["sub"]
    case Users.get_user!(user) do
      {:ok, user} ->
        {:ok, user}
      {:error, :not_found} ->
        {:error, :not_found}
    end
  end
end