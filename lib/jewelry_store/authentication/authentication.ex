defmodule JewelryStore.Authentication do
  alias JewelryStore.Authentication.Guardian

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
end
