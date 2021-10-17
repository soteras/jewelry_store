defmodule JewelryStoreWeb.Plug.PublicAbsinthe do
  defdelegate init(opts), to: Absinthe.Plug
  defdelegate call(conn, opts), to: Absinthe.Plug
end
