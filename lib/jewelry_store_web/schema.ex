defmodule JewelryStoreWeb.Schema do
  use Absinthe.Schema

  alias JewelryStoreWeb.Middleware.ErrorHandler

  import_types(JewelryStoreWeb.Schema.Categories.Mutation)

  query do
    field :wip, :string
  end

  mutation do
    import_fields(:create_category_mutation)
    import_fields(:update_category_mutation)
  end

  def middleware(middleware, _field, %{identifier: type}) when type in [:query, :mutation],
    do: middleware ++ [ErrorHandler]

  def middleware(middleware, _field, _object), do: middleware
end
