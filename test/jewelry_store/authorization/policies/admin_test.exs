defmodule JewelryStore.Authorization.Policies.AdminTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Authorization.Policies.Admin

  @actions [:list, :show, :create, :update, :delete]

  test "authorize/3: verify admin policy" do
    user = insert(:user, admin: true)

    Enum.each(@actions, fn action ->
      assert Bodyguard.permit?(Admin, action, user)
    end)
  end

  test "authorize/3: verify user policy" do
    user = insert(:user)

    Enum.each(@actions, fn action ->
      refute Bodyguard.permit?(Admin, action, user)
    end)
  end
end
