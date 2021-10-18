defmodule JewelryStoreWeb.Schema do
  use Absinthe.Schema

  alias JewelryStoreWeb.Middleware.ErrorHandler

  query do
    field :wip, :string
  end

  def middleware(middleware, _field, %{identifier: type}) when type in [:query, :mutation],
    do: middleware ++ [ErrorHandler]

  def middleware(middleware, _field, _object), do: middleware
end
