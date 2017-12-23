defmodule Hades.Accounts.Encryption do
  import Ecto.Changeset
  import Comeonin.Bcrypt

  def hash_password(%{valid?: false} = changeset), do: changeset
  def hash_password(%{valid?: true} = changeset) do
    hashedpw = hashpwsalt(get_field(changeset, :password))
    put_change(changeset, :password_hash, hashedpw)
  end

  def change_password(changeset) do
   case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password, password_confirmation: password_confirmation}} ->
        case password == password_confirmation do
          true  -> hash_password(changeset)
          false -> add_error(changeset, :password_confirmation, "Passwords don't match")
        end
      _ ->
        changeset
    end
  end

  def put_authentication_token(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :auth_token, SecureRandom.urlsafe_base64(32))
      _ ->
        changeset
    end
  end
end