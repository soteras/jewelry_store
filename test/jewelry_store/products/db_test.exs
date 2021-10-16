defmodule JewelryStore.Products.DbTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Products.Db

  describe "create_category/1" do
    test "with success creates category" do
      {:ok, category} = Db.create_category(%{name: "Anéis com Pérolas"})

      assert category.name == "Anéis com Pérolas"
      assert category.slug == "aneis-com-perolas"
    end

    test "with error not creates category" do
      {:error, changeset} = Db.create_category(%{})

      refute changeset.valid?
    end
  end

  describe "update_category/2" do
    test "with success updates category" do
      category = insert(:category)

      {:ok, category} = Db.update_category(category, %{name: "Anéis com Pérolas"})

      assert category.name == "Anéis com Pérolas"
      assert category.slug == "aneis-com-perolas"
    end

    test "with error not updates category" do
      category = insert(:category)

      {:error, changeset} = Db.update_category(category, %{name: ""})

      refute changeset.valid?
    end
  end

  describe "get_category_by_slug/1" do
    test "returns category" do
      category = insert(:category, name: "Promoções")

      assert category.id == Db.get_category_by_slug("promocoes").id
    end

    test "returns nil" do
      refute Db.get_category_by_slug("wrong-slug")
    end
  end
end
