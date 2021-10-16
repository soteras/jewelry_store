defmodule JewelryStore.Users.Db do
  alias JewelryStore.Repo
  alias JewelryStore.Users.User

  @type user :: User.t()
  @type changeset :: Ecto.Changeset.t()

  @spec create_user(map) :: {:ok, user} | {:error, changeset}
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec get_user_by_id(integer) :: user | nil
  def get_user_by_id(id), do: Repo.get_by(User, id: id)
end
