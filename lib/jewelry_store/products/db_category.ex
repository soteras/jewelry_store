defmodule JewelryStore.Products.DbCategory do
  alias JewelryStore.Products.Category
  alias JewelryStore.Repo

  @type category :: Category.t()
  @type changeset :: Ecto.Changeset.t()

  import JewelryStore.Products.CategoryQueries

  @spec create_category(map) :: {:ok, category} | {:error, changeset}
  def create_category(attrs) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_category(category, map) :: {:ok, category} | {:error, changeset}
  def update_category(category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @spec get_category_by_id(integer) :: {:ok, category} | {:error, atom}
  def get_category_by_id(id) do
    case Repo.get_by(Category, id: id) do
      nil -> {:error, :not_found}
      category -> {:ok, category}
    end
  end

  @spec list_categories() :: [category]
  def list_categories, do: {:ok, Repo.all(base_query())}
end
