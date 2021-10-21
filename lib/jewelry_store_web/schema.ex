defmodule JewelryStoreWeb.Schema do
  use Absinthe.Schema

  alias JewelryStoreWeb.Middleware.ErrorHandler

  # types
  import_types(JewelryStoreWeb.Schema.Categories.Type)

  # queries
  import_types(JewelryStoreWeb.Schema.Categories.Query)

  # mutations
  import_types(JewelryStoreWeb.Schema.Categories.Mutation)

  query do
    import_fields(:categories_query)
  end

  mutation do
    import_fields(:create_category_mutation)
    import_fields(:update_category_mutation)
  end

  def middleware(middleware, _field, %{identifier: type}) when type in [:query, :mutation],
    do: middleware ++ [ErrorHandler]

  def middleware(middleware, _field, _object), do: middleware
end
