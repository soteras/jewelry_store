defmodule JewelryStoreWeb.Schema.Signup.Mutation do
  use Absinthe.Schema.Notation

  alias JewelryStoreWeb.Schema.Signup.Resolver

  import_types(JewelryStoreWeb.Schema.Signup.Input)

  object :signup_mutation do
    @desc "Cria um novo usuário"
    field :create_user, type: :session do
      arg(:input, non_null(:signup_input))
      resolve(&Resolver.create_post/3)
    end
  end
end
