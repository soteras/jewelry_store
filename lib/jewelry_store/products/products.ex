defmodule JewelryStore.Products do
  alias JewelryStore.Products.Db

  defdelegate authorize(action, user, params), to: JewelryStore.Authorization.Policies.Admin
  defdelegate create_category(attrs), to: Db
  defdelegate update_category(category, attrs), to: Db
  defdelegate get_category_by_slug(slug), to: Db
end
