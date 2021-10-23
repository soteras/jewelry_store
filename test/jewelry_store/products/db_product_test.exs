defmodule JewelryStore.Products.DbProductTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Products.DbProduct, as: Db

  describe "create_product/1" do
    test "with success creates product" do
      category = insert(:category)

      attrs = %{
        name: "Brinco Réplica Estrelinha Tripla Semijoias Antialérgicas Banhadas a Ouro 22k",
        sku: "BR1878",
        price: 1899,
        short_description:
          "Brinco Réplica Estrelinha Tripla Semijoias Antialérgicas Banhadas a Ouro 22k",
        description:
          "Brinco Réplica Estrelinha Tripla Semijoias Antialérgicas Banhadas a Ouro 22k",
        quantity: 11,
        active: true,
        category_id: category.id
      }

      {:ok, product} = Db.create_product(attrs)

      assert product.name ==
               "Brinco Réplica Estrelinha Tripla Semijoias Antialérgicas Banhadas a Ouro 22k"

      assert product.slug ==
               "brinco-replica-estrelinha-tripla-semijoias-antialergicas-banhadas-a-ouro-22k"

      assert Money.to_string(product.price) == "18,99"

      assert product.short_description ==
               "Brinco Réplica Estrelinha Tripla Semijoias Antialérgicas Banhadas a Ouro 22k"

      assert product.description ==
               "Brinco Réplica Estrelinha Tripla Semijoias Antialérgicas Banhadas a Ouro 22k"

      assert product.quantity == 11
      assert product.active
    end

    test "with error not creates product" do
      {:error, changeset} = Db.create_product(%{})

      refute changeset.valid?
    end
  end
end
