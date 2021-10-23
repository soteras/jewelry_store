defmodule JewelryStore.Products do
  alias JewelryStore.Products.DbCategory
  alias JewelryStore.Products.DbProduct

  defdelegate authorize(action, user, params), to: JewelryStore.Authorization.Policies.Admin
  defdelegate create_category(attrs), to: DbCategory
  defdelegate update_category(category, attrs), to: DbCategory
  defdelegate get_category_by_id(id), to: DbCategory
  defdelegate list_categories(), to: DbCategory

  defdelegate create_product(attrs), to: DbProduct
  defdelegate update_product(product, attrs), to: DbProduct
  defdelegate get_product_by_id(id), to: DbProduct
end
