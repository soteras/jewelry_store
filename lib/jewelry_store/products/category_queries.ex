defmodule JewelryStore.Products.CategoryQueries do
  import Ecto.Query

  alias JewelryStore.Products.Category

  @type query :: Ecto.Query.t()

  @spec base_query() :: query
  def base_query do
    from(category in Category, order_by: category.name)
  end
end
