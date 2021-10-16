defmodule JewelryStore.Authorization.Policies.UserTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Authorization.Policies.User

  setup do
    user = insert(:user)

    %{user: user}
  end

  describe "authorize/3: list" do
    test "returns true", %{user: user} do
      assert Bodyguard.permit?(User, :list, user, %{})
    end
  end

  describe "authorize/3: create" do
    test "returns true", %{user: user} do
      assert Bodyguard.permit?(User, :create, user, %{})
    end
  end

  describe "authorize/3: show" do
    test "returns true", %{user: user} do
      assert Bodyguard.permit?(User, :show, user, %{user_id: user.id})
    end

    test "returns false", %{user: user} do
      refute Bodyguard.permit?(User, :show, user, %{user_id: 999})
    end
  end

  describe "authorize/3: update" do
    test "returns true", %{user: user} do
      assert Bodyguard.permit?(User, :update, user, %{user_id: user.id})
    end

    test "returns false", %{user: user} do
      refute Bodyguard.permit?(User, :update, user, %{user_id: 999})
    end
  end

  describe "authorize/3: delete" do
    test "returns true", %{user: user} do
      assert Bodyguard.permit?(User, :delete, user, %{user_id: user.id})
    end

    test "returns false", %{user: user} do
      refute Bodyguard.permit?(User, :delete, user, %{user_id: 999})
    end
  end
end
