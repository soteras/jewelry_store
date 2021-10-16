defmodule JewelryStore.Users.Db do
  alias JewelryStore.Repo
  alias JewelryStore.Users.User

  @type user :: User.t()
  @type changeset :: Ecto.Changeset.t()

  import JewelryStore.Users.Queries

  @spec create_user(map) :: {:ok, user} | {:error, changeset}
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec get_user_by_id(integer) :: user | nil
  def get_user_by_id(id), do: Repo.get_by(User, id: id)

  @spec get_user_by_email_or_cpf(String.t()) :: user | nil
  def get_user_by_email_or_cpf(username) do
    username =
      username
      |> String.downcase()
      |> format_cpf_or_term()

    user_base_query()
    |> get_user_by_email_or_cpf(username)
    |> Repo.one()
  end

  defp format_cpf_or_term(username) do
    case Brcpfcnpj.cpf_format(%Cpf{number: username}) do
      nil -> username
      cpf -> cpf
    end
  end
end
