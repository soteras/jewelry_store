defmodule JewelryStore.Products.DbCategoryTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Users.DbCategory, as: Db

  describe "create_category/1" do
    test "with success creates category" do
      {:ok, category} = Db.create_category(%{name: "Anéis com Pérolas"})

      assert category.name == "Anéis com Pérolas"
      assert category.slug == "aneis-com-perolas"
      refute category.active
    end

    test "with error not creates category" do
      {:error, changeset} = Db.create_category(%{})

      refute changeset.valid?
    end
  end

  describe "update_category/2" do
    test "with success updates category" do
      category = insert(:category)

      {:ok, category} = Db.update_category(category, %{name: "Anéis com Pérolas", active: true})

      assert category.name == "Anéis com Pérolas"
      assert category.slug == "aneis-com-perolas"
      assert category.active
    end

    test "with error not updates category" do
      category = insert(:category)

      {:error, changeset} = Db.update_category(category, %{name: ""})

      refute changeset.valid?
    end
  end

  describe "get_category_by_id/1" do
    test "returns category" do
      category = insert(:category)

      assert Db.get_category_by_id(category.id) == category.id
    end

    test "returns nil" do
      category = insert(:category)

      refute Db.get_category_by_id(category.id)
    end
  end
end
