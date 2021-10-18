defmodule JewelryStoreWeb.PublicSchema do
  use Absinthe.Schema

  alias JewelryStoreWeb.Middleware.ErrorHandler

  import_types(JewelryStoreWeb.Schema.Shared.Type)
  import_types(JewelryStoreWeb.Schema.Signup.Mutation)
  import_types(JewelryStoreWeb.Schema.Signin.Mutation)

  query do
    field :wip, :string
  end

  mutation do
    import_fields(:signup_mutation)
    import_fields(:signin_mutation)
  end

  def middleware(middleware, _field, %{identifier: type}) when type in [:query, :mutation],
    do: middleware ++ [ErrorHandler]

  def middleware(middleware, _field, _object), do: middleware
end
