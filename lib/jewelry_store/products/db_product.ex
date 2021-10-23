defmodule JewelryStore.Products.DbProduct do
  alias JewelryStore.Products.Product
  alias JewelryStore.Repo

  @type product :: Product.t()
  @type changeset :: Ecto.Changeset.t()

  @spec create_product(map) :: {:ok, product} | {:error, changeset}
  def create_product(attrs) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end
end
