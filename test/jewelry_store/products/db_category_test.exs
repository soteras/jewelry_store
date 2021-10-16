defmodule JewelryStore.Products.DbCategoryTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Products.DbCategory, as: Db

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
      {:ok, result} = Db.get_category_by_id(category.id)

      assert category.id == result.id
    end

    test "returns nil" do
      assert {:error, :not_found} = Db.get_category_by_id(99)
    end
  end

  describe "list_categories/0" do
    test "returns a list of categories" do
      insert(:category, name: "Anéis em Ródio")
      insert(:category, name: "Brincos com Zircônias")

      assert [%{name: "Anéis em Ródio"}, %{name: "Brincos com Zircônias"}] = Db.list_categories()
    end

    test "returns an empty list" do
      assert [] = Db.list_categories()
    end
  end
end
