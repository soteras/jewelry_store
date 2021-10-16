defmodule JewelryStore.Products.CategoryTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Products.Category
  alias JewelryStore.Repo

  describe "changeset/2: valid attrs" do
    test "create changeset" do
      changeset = Category.changeset(%Category{}, %{name: "Promoções"})

      assert changeset.valid?
    end
  end

  describe "changeset/2: name" do
    test "is empty" do
      changeset = Category.changeset(%Category{}, %{name: ""})

      assert get_error_message(changeset, :name) == "can't be blank"
    end

    test "is not unique" do
      insert(:category, name: "Anéis")

      {:error, changeset} =
        %Category{}
        |> Category.changeset(%{name: "Anéis"})
        |> Repo.insert()

      assert get_error_message(changeset, :name) == "has already been taken"
    end
  end
end
