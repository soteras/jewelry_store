defmodule JewelryStoreWeb.Schema.Products.Mutation do
  use Absinthe.Schema.Notation

  alias JewelryStoreWeb.Schema.Category.Resolver

  import_types(JewelryStoreWeb.Schema.Products.Input)

  object :create_product_mutation do
    @desc "Create product"
    field :create_product, type: :product do
      arg(:input, non_null(:product_input))
      resolve(&Resolver.create_product/3)
    end
  end

  object :update_product_mutation do
    @desc "Update product"
    field :update_product, type: :product do
      arg(:id, non_null(:integer))
      arg(:input, non_null(:product_input))
      resolve(&Resolver.update_product/3)
    end
  end
end
