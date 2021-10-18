defmodule JewelryStoreWeb.Schema.Signup.Type do
  use Absinthe.Schema.Notation

  object :session do
    field :name, :string
    field :nickname, :string
    field :token, :string
  end

  input_object :signup_input do
    field :name, non_null(:string)
  end
end
