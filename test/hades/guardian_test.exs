defmodule Hades.GuardianTest do
  use Hades.DataCase

  import Hades.Factory

  alias Hades.FakeData

  setup do
    user = insert(:user, email: FakeData.email, is_admin: FakeData.boolean)
    {:ok, _tokens, claims} = Hades.Guardian.encode_and_sign(user)
    %{user: user, claims: claims}
  end

  describe "subject_for_token/2" do
    test "returns resource id when data is valid", %{user: user} do
      assert Hades.Guardian.subject_for_token(user, nil) == {:ok, to_string(user.id)}
    end

    test "returns unknow resource when no data is provided" do
      assert Hades.Guardian.subject_for_token(nil, nil) == {:error, :unknown_resource}
    end
  end

  describe "resource_from_claims/1" do
    test "returns resource when data is valid", %{claims: claims} do
      assert Hades.Guardian.resource_from_claims(claims) != %{}
    end

    test "returns error when data is invalid" do
      assert Hades.Guardian.resource_from_claims(%{"sub" => "-1"}) == {:error, :not_found}
    end
  end
end