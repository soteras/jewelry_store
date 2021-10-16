defmodule JewelryStore.UsersTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Users

  describe "get_user_by_email_or_cpf/1" do
    setup do
      user = insert(:user, email: "test@gmail.com")

      %{user_id: user.id}
    end

    test "returns an user when success", %{user_id: user_id} do
      assert {:ok, %{id: ^user_id}} = Users.get_user_by_email_or_cpf("test@gmail.com")
    end

    test "returns an error when error" do
      assert {:error, :not_found} == Users.get_user_by_email_or_cpf("wrong_user@gmail.com")
    end
  end
end
