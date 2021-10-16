defmodule JewelryStore.Users.Db do
  alias JewelryStore.Users.User
  alias JewelryStore.Repo

  @type user :: User.t()
  @type changeset :: Ecto.Changeset.t()

  @spec create_user(map) :: {:ok, user} | {:error, changeset}
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
