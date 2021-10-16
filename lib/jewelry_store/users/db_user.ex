defmodule JewelryStore.Users.DbUser do
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

  @spec get_user_by_id(integer) :: {:ok, user} | {:error, atom}
  def get_user_by_id(id) do
    case Repo.get_by(User, id: id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @spec get_user_by_email_or_cpf(String.t()) :: {:ok, user} | {:error, atom}
  def get_user_by_email_or_cpf(username) do
    username =
      username
      |> String.downcase()
      |> format_cpf_or_term()

    user =
      user_base_query()
      |> get_user_by_email_or_cpf(username)
      |> Repo.one()

    case user do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  defp format_cpf_or_term(username) do
    case Brcpfcnpj.cpf_format(%Cpf{number: username}) do
      nil -> username
      cpf -> cpf
    end
  end
end
