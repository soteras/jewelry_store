defmodule JewelryStore.Users do
  alias JewelryStore.Users.Db

  defdelegate create_user(attrs), to: Db
  defdelegate get_user_by_id(id), to: Db
end
