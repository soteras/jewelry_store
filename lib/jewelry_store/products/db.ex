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
end
