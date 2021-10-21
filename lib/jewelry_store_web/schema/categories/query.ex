defmodule JewelryStoreWeb.Schema.Categories.Query do
  use Absinthe.Schema.Notation

  alias JewelryStoreWeb.Schema.Categories.Resolver

  object :categories_query do
    @desc "Get categories"
    field :categories, type: list_of(:category) do
      resolve(&Resolver.get_categories/3)
    end
  end
end
