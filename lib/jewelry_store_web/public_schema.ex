defmodule JewelryStoreWeb.PublicSchema do
  use Absinthe.Schema

  alias JewelryStoreWeb.Middleware.ErrorHandler

  import_types(JewelryStoreWeb.Schema.Signup.Mutation)

  query do
    field :wip, :string
  end

  mutation do
    import_fields(:signup_mutation)
  end

  def middleware(middleware, _field, %{identifier: type}) when type in [:query, :mutation],
    do: middleware ++ [ErrorHandler]

  def middleware(middleware, _field, _object), do: middleware
end
