defmodule JewelryStoreWeb.Schema.Shared.Type do
  use Absinthe.Schema.Notation

  object :session do
    field :name, :string
    field :nickname, :string
    field :token, :string
  end
end
