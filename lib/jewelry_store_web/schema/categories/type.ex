defmodule JewelryStoreWeb.Schema.Categories.Type do
  use Absinthe.Schema.Notation

  object :category do
    field :name, :string
    field :slug, :string
    field :active, :boolean
  end

  input_object :category_input do
    description("Campos da criação de categoria")

    field :name, non_null(:string), description: "Nome"
    field :active, non_null(:boolean), description: "Ativo?"
  end
end
