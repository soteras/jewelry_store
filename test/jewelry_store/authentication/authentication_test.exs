defmodule JewelryStore.AuthenticationTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Authentication
  alias JewelryStore.Authentication.Guardian

  describe "generate_refresh_token/1" do
    test "generate token" do
      user = insert(:user)
      user_id = Integer.to_string(user.id)

      {:ok, token} = Authentication.generate_refresh_token(user)

      assert {:ok, %{"typ" => "refresh", "sub" => ^user_id}} = Guardian.decode_and_verify(token)
    end

    test "returns an error" do
      assert {:error, :error_to_generate_token} = Authentication.generate_refresh_token(%{})
    end
  end
end
