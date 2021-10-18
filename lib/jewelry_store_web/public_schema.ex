defmodule JewelryStoreWeb.PublicSchema do
  use Absinthe.Schema

  import_types(JewelryStoreWeb.Schema.Signup.Mutation)

  query do
    field :wip, :string
  end

  mutation do
    import_fields(:signup_mutation)
  end
end
