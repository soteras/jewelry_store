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
end
