defmodule JewelryStore.Users do
  alias JewelryStore.Users.Db

  defdelegate create_user(attrs), to: Db
end
