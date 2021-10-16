defmodule JewelryStore.Users do
  alias JewelryStore.Users.DbUser

  @type user :: JewelryStore.Users.User.t()

  defdelegate authorize(action, user, params), to: JewelryStore.Authorization.Policies.Admin
  defdelegate create_user(attrs), to: DbUser
  defdelegate get_user_by_id(id), to: DbUser
  defdelegate get_user_by_email_or_cpf(username), to: DbUser
end
