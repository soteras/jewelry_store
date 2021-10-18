defmodule JewelryStoreWeb.Schema.Signin.Mutation do
  use Absinthe.Schema.Notation

  alias JewelryStoreWeb.Schema.Signin.Resolver

  import_types(JewelryStoreWeb.Schema.Signin.Type)

  object :signin_mutation do
    @desc "Login"
    field :signin, type: :session do
      arg(:input, non_null(:signin_input))
      resolve(&Resolver.signin/3)
    end
  end
end
