defmodule JewelryStoreWeb.Schema.Categories.Type do
  use Absinthe.Schema.Notation

  object :category do
    field :name, :string
    field :slug, :string
    field :active, :boolean
  end
end
