defmodule JewelryStoreWeb.Schema.Signin.Type do
  use Absinthe.Schema.Notation

  import_types(JewelryStoreWeb.Schema.Shared.Type)

  input_object :signin_input do
    description("Campos para login")

    field :username, non_null(:string), description: "E-mail ou CPF"
    field :password, non_null(:string), description: "senha"
  end
end
