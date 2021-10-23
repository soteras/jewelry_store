defmodule JewelryStoreWeb.Schema.Products.Type do
  use Absinthe.Schema.Notation

  object :product do
    field :name, :string, description: "Nome"
    field :slug, :string, description: "Slug"
    field :sku, :string, description: "SKU"
    field :price, :integer, description: "Preço em centavos"
    field :short_description, :string, description: "Descrição curta"
    field :description, :string, description: "Descrição longa"
    field :quantity, :integer, description: "Quantidade em estoque"
    field :active, :boolean, description: "Ativo?"
  end
end
