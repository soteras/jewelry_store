defmodule JewelryStore.Products.ProductTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Products.Product
  alias JewelryStore.Repo

  @attrs %{
    name: "Anel Seta Lisa Aro Aberto Semijoias Antialérgicas Banhadas a Ouro",
    sku: "AN679",
    price: "1200,23",
    short_description: "Anel seta lisa aro aberto, semijoia antialérgica banhada a ouro 22k.",
    description: "Anel seta lisa aro aberto, semijoia antialérgica banhada a ouro 22k.",
    category_id: 1,
    quantity: 29
  }

  setup do
    insert(:category, id: 1)
    :ok
  end

  describe "changeset/2: valid attrs" do
    test "create changeset" do
      changeset = Product.changeset(%Product{}, @attrs)

      assert changeset.valid?
    end
  end

  describe "changeset/2: name" do
    test "is empty" do
      changeset = Product.changeset(%Product{}, %{@attrs | name: ""})

      assert get_error_message(changeset, :name) == "can't be blank"
    end

    test "is not unique" do
      insert(:product, name: "Anel Seta Lisa")

      {:error, changeset} =
        %Product{}
        |> Product.changeset(%{@attrs | name: "Anel Seta Lisa"})
        |> Repo.insert()

      assert get_error_message(changeset, :name) == "has already been taken"
    end
  end

  describe "changeset/2: sku" do
    test "is empty" do
      changeset = Product.changeset(%Product{}, %{@attrs | sku: ""})

      assert get_error_message(changeset, :sku) == "can't be blank"
    end

    test "is not unique" do
      insert(:product, sku: "ABC123")

      {:error, changeset} =
        %Product{}
        |> Product.changeset(%{@attrs | sku: "ABC123"})
        |> Repo.insert()

      assert get_error_message(changeset, :sku) == "has already been taken"
    end
  end

  describe "changeset/2: price" do
    test "is empty" do
      changeset = Product.changeset(%Product{}, %{@attrs | price: ""})

      assert get_error_message(changeset, :price) == "can't be blank"
    end
  end

  describe "changeset/2: short_description" do
    test "is empty" do
      changeset = Product.changeset(%Product{}, %{@attrs | short_description: ""})

      assert get_error_message(changeset, :short_description) == "can't be blank"
    end
  end

  describe "changeset/2: description" do
    test "is empty" do
      changeset = Product.changeset(%Product{}, %{@attrs | description: ""})

      assert get_error_message(changeset, :description) == "can't be blank"
    end
  end

  describe "changeset/2: category_id" do
    test "is empty" do
      changeset = Product.changeset(%Product{}, %{@attrs | category_id: nil})

      assert get_error_message(changeset, :category_id) == "can't be blank"
    end

    test "not exist" do
      {:error, changeset} =
        %Product{}
        |> Product.changeset(%{@attrs | category_id: 999})
        |> Repo.insert()

      assert get_error_message(changeset, :category) == "does not exist"
    end
  end

  describe "changeset/2: quantity" do
    test "less than 0" do
      changeset = Product.changeset(%Product{}, %{@attrs | quantity: -1})

      assert get_error_message(changeset, :quantity) ==
               "must be greater than or equal to %{number}"
    end
  end
end
