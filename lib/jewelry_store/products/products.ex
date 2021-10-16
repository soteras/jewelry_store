defmodule JewelryStore.Products do
  alias JewelryStore.Products.DbCategory

  defdelegate authorize(action, user, params), to: JewelryStore.Authorization.Policies.Admin
  defdelegate create_category(attrs), to: DbCategory
  defdelegate update_category(category, attrs), to: DbCategory
  defdelegate get_category_by_id(id), to: DbCategory
end
