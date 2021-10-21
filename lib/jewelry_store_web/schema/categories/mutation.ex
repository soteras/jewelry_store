defmodule JewelryStoreWeb.Schema.Categories.Mutation do
  use Absinthe.Schema.Notation

  alias JewelryStoreWeb.Schema.Categories.Resolver

  import_types(JewelryStoreWeb.Schema.Categories.Input)

  object :create_category_mutation do
    @desc "Create category"
    field :create_category, type: :category do
      arg(:input, non_null(:category_input))
      resolve(&Resolver.create_category/3)
    end
  end

  object :update_category_mutation do
    @desc "Update category"
    field :update_category, type: :category do
      arg(:id, non_null(:integer))
      arg(:input, non_null(:category_input))
      resolve(&Resolver.update_category/3)
    end
  end
end
