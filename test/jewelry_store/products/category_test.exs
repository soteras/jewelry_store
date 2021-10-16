defmodule JewelryStore.Products.CategoryTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Repo
  alias JewelryStore.Products.Category

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

    test "more than 25" do
      changeset = Category.changeset(%Category{}, %{name: repeat_str("a", 26)})

      assert get_error_message(changeset, :name) == "should be at most %{count} character(s)"
    end
  end
end
