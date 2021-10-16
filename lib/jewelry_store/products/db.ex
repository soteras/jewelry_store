defmodule JewelryStore.Products.Db do
  alias JewelryStore.Repo
  alias JewelryStore.Products.Category

  @type category :: Category.t()
  @type changeset :: Ecto.Changeset.t()

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

  @spec get_category_by_slug(String.t()) :: category | nil
  def get_category_by_slug(slug), do: Repo.get_by(Category, slug: slug)
end
