defmodule JewelryStoreWeb.Schema do
  use Absinthe.Schema

  alias JewelryStoreWeb.Middleware.ErrorHandler

  # types
  import_types(JewelryStoreWeb.Schema.Categories.Type)
  import_types(JewelryStoreWeb.Schema.Products.Type)

  # queries
  import_types(JewelryStoreWeb.Schema.Categories.Query)

  # mutations
  import_types(JewelryStoreWeb.Schema.Categories.Mutation)
  import_types(JewelryStoreWeb.Schema.Products.Mutation)

  query do
    import_fields(:categories_query)
  end

  mutation do
    import_fields(:create_category_mutation)
    import_fields(:update_category_mutation)
    import_fields(:create_product_mutation)
    import_fields(:update_product_mutation)
  end

  def middleware(middleware, _field, %{identifier: type}) when type in [:query, :mutation],
    do: middleware ++ [ErrorHandler]

  def middleware(middleware, _field, _object), do: middleware
end
