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

  describe "update_product/2" do
    test "with success updates product" do
      product = insert(:product)

      attrs = %{
        name: "Brinco Réplica Estrelinha Tripla Semijoias Antialérgicas Banhadas a Ouro 22k",
        sku: "BR1878",
        price: 1899,
        short_description:
          "Brinco Réplica Estrelinha Tripla Semijoias Antialérgicas Banhadas a Ouro 22k",
        description:
          "Brinco Réplica Estrelinha Tripla Semijoias Antialérgicas Banhadas a Ouro 22k",
        quantity: 11,
        active: true
      }

      {:ok, product} = Db.update_product(product, attrs)

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

    test "with error not updates product" do
      product = insert(:product)
      {:error, changeset} = Db.update_product(product, %{name: ""})

      refute changeset.valid?
    end
  end

  describe "get_product_by_id/1" do
    test "returns product" do
      product = insert(:product)

      {:ok, %{id: id}} = Db.get_product_by_id(product.id)

      assert id == product.id
    end

    test "returns not found" do
      assert {:error, :not_found} == Db.get_product_by_id(99)
    end
  end
end
