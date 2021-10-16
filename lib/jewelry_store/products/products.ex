defmodule JewelryStore.Products do
  alias JewelryStore.Products.Db

  defdelegate create_category(attrs), to: Db
  defdelegate update_category(category, attrs), to: Db
end
