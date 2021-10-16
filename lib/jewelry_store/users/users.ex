defmodule JewelryStore.Users do
  alias JewelryStore.Users.Db

  @type user :: JewelryStore.Users.User.t()

  defdelegate authorize(action, user, params), to: JewelryStore.Authorization.Policies.Admin
  defdelegate create_user(attrs), to: Db
  defdelegate get_user_by_id(id), to: Db

  @spec get_user_by_email_or_cpf(String.t()) :: {:ok, user} | {:error, term}
  def get_user_by_email_or_cpf(username) do
    case Db.get_user_by_email_or_cpf(username) do
      nil -> {:error, "not found"}
      user -> {:ok, user}
    end
  end
end
