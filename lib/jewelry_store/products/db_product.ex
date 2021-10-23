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

  @spec update_product(product, map) :: {:ok, product} | {:error, changeset}
  def update_product(product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @spec get_product_by_id(integer) :: {:ok, product} | {:error, atom}
  def get_product_by_id(id) do
    case Repo.get_by(Product, id: id) do
      nil -> {:error, :not_found}
      product -> {:ok, product}
    end
  end
end
