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

  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end
end