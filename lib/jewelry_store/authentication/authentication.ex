defmodule JewelryStore.Authentication do
  alias JewelryStore.Authentication.Guardian
  alias JewelryStore.Users

  @type user :: JewelryStore.Users.User.t()
  @type jwt_token :: String.t()

  @spec generate_refresh_token(user) :: {:ok, jwt_token} | {:error, term}
  def generate_refresh_token(user) do
    result = Guardian.encode_and_sign(user, %{}, token_type: "refresh", ttl: {1, :week})

    case result do
      {:ok, token, _} ->
        {:ok, token}

      {:error, error} ->
        {:error, error}
    end
  end

  @spec authenticate(String.t(), String.t()) :: {:ok, user, jwt_token} | {:error, term}
  def authenticate(username, password) do
    with {:ok, user} <- Users.get_user_by_email_or_cpf(username),
      {:ok, _user} <- Bcrypt.check_pass(user, password),
      {:ok, token} <- generate_refresh_token(user) do
        {:ok, user, token}
    else
      {:error, "not found"} ->
        {:error, "user not found"}

      {:error, "invalid password"} ->
        {:error, "password not valid"}
    end
  end
end
