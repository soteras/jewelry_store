defmodule JewelryStoreWeb.Schema.Products.Input do
  use Absinthe.Schema.Notation

  input_object :product_input do
    description("Input de produto")

    field :name, non_null(:string), description: "Nome"
    field :sku, non_null(:string), description: "SKU"
    field :price, non_null(:integer), description: "Preço em centavos"
    field :short_description, non_null(:string), description: "Descrição curta"
    field :description, non_null(:string), description: "Descrição longa"
    field :quantity, :integer, description: "Quantidade em estoque"
    field :category_id, non_null(:integer), description: "ID da categoria"
    field :active, :boolean, description: "Ativo?"
  end
end
