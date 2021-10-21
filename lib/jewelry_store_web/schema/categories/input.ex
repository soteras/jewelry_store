defmodule JewelryStoreWeb.Schema.Categories.Input do
  use Absinthe.Schema.Notation

  input_object :category_input do
    description("Campos da criação de categoria")

    field :name, non_null(:string), description: "Nome"
    field :active, non_null(:boolean), description: "Ativo?"
  end
end
