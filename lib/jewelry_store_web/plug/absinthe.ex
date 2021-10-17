defmodule JewelryStoreWeb.Plug.Absinthe do
  defdelegate init(opts), to: Absinthe.Plug
  defdelegate call(conn, opts), to: Absinthe.Plug
end
