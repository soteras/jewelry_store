defmodule JewelryStore.Users.DbUserTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Users.DbUser, as: Db

  @attrs %{
    name: "Antonio Carlos",
    cpf: "09986414059",
    rg: "273394721",
    gender: "male",
    nickname: "Antony",
    birthdate: ~D[2021-10-15],
    cellphone: "(11) 98999-9999",
    email: "antonio@gmail.com",
    password: "abc12345",
    password_confirmation: "abc12345",
    admin: true
  }

  describe "create_user/1" do
    test "with success create user" do
      {:ok, user} = Db.create_user(@attrs)

      assert user.name == "Antonio Carlos"
      assert user.cpf == "099.864.140-59"
      assert user.rg == "273394721"
      assert user.gender == "male"
      assert user.nickname == "Antony"
      assert user.birthdate == ~D[2021-10-15]
      assert user.cellphone == "(11) 98999-9999"
      assert user.email == "antonio@gmail.com"
      assert is_binary(user.password_hash)
      refute user.admin
    end

    test "with error not creates user" do
      {:error, changeset} = Db.create_user(%{})

      refute changeset.valid?
    end
  end

  describe "get_user_by_id/1" do
    test "returns user" do
      user = insert(:user)
      {:ok, result} = Db.get_user_by_id(user.id)

      assert result.id == user.id
    end

    test "returns nil" do
      assert {:error, :not_found} = Db.get_user_by_id(1)
    end
  end

  describe "get_user_by_email_or_cpf/1" do
    setup do
      user = insert(:user, email: "test@gmail.com", cpf: "72652408046")

      %{user_id: user.id}
    end

    test "get user by email", %{user_id: user_id} do
      {:ok, user} = Db.get_user_by_email_or_cpf("test@gmail.COM")

      assert user_id == user.id
    end

    test "get user by cpf", %{user_id: user_id} do
      {:ok, user} = Db.get_user_by_email_or_cpf("72652408046")

      assert user_id == user.id
    end

    test "returns nil when user is not found" do
      assert {:error, :not_found} = Db.get_user_by_email_or_cpf("1111")
    end
  end
end
