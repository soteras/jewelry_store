defmodule JewelryStore.Users.UserQueries do
  import Ecto.Query

  alias JewelryStore.Users.User

  @type query :: Ecto.Query.t()

  @spec base_query() :: query
  def base_query do
    from(user in User)
  end

  @spec get_user_by_email_or_cpf(query, term) :: query
  def get_user_by_email_or_cpf(query, term) do
    query
    |> where([u], u.email == ^term)
    |> or_where([u], u.cpf == ^term)
  end
end
