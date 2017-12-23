defmodule Hades.Accounts.Encryption do
  import Ecto.Changeset
  import Comeonin.Bcrypt

  def hash_password(%{valid?: false} = changeset), do: changeset
  def hash_password(%{valid?: true} = changeset) do
    hashedpw = hashpwsalt(get_field(changeset, :password))
    put_change(changeset, :password_hash, hashedpw)
  end
end