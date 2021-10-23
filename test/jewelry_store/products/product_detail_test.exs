defmodule JewelryStore.Products.ProductDetailTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Products.ProductDetail

  describe "changeset/2: valid attrs" do
    test "create changeset" do
      product = insert(:product)

      attrs = %{
        type: "banho",
        value: "Ouro 22k",
        product_id: product.id
      }

      changeset = ProductDetail.changeset(%ProductDetail{}, attrs)

      assert changeset.valid?
    end
  end

  describe "changeset/2: type" do
    test "is empty" do
      changeset = ProductDetail.changeset(%ProductDetail{}, %{type: ""})

      assert get_error_message(changeset, :type) == "can't be blank"
    end

    test "invalid type" do
      changeset = ProductDetail.changeset(%ProductDetail{}, %{type: "abc123"})

      assert get_error_message(changeset, :type) == "is invalid"
    end
  end

  describe "changeset/2: value" do
    test "is empty" do
      changeset = ProductDetail.changeset(%ProductDetail{}, %{value: ""})

      assert get_error_message(changeset, :value) == "can't be blank"
    end
  end

  describe "changeset/2: product" do
    test "product not exist" do
      attrs = %{
        type: "banho",
        value: "Ouro 22k",
        product_id: 99
      }

      {:error, changeset} =
        %ProductDetail{}
        |> ProductDetail.changeset(attrs)
        |> Repo.insert()

      assert get_error_message(changeset, :product) == "does not exist"
    end
  end
end
