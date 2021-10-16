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

  describe "authenticate/2" do
    setup do
      user = insert(:user, email: "test@gmail.com", cpf: "55289136088")

      %{user: user}
    end

    test "authenticates user by email", %{user: user} do
      {:ok, current_user, token} = Authentication.authenticate("TEst@gmail.com", "abc12345")
      user_id = Integer.to_string(user.id)

      assert {:ok, %{"typ" => "refresh", "sub" => ^user_id}} = Guardian.decode_and_verify(token)
      assert current_user.id == user.id
    end

    test "authenticates user by cpf", %{user: user} do
      {:ok, current_user, token} = Authentication.authenticate("55289136088", "abc12345")
      user_id = Integer.to_string(user.id)

      assert {:ok, %{"typ" => "refresh", "sub" => ^user_id}} = Guardian.decode_and_verify(token)
      assert current_user.id == user.id
    end

    test "returns an error when user not exist" do
      assert {:error, "user not found"} =
               Authentication.authenticate("test1@gmail.com", "abc12345")
    end

    test "returns an error when password is not valid" do
      assert {:error, "password not valid"} = Authentication.authenticate("test@gmail.com", "abc")
    end
  end
end
