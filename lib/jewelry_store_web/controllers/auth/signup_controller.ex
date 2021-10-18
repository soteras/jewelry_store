defmodule JewelryStoreWeb.Auth.SignupController do
  use JewelryStoreWeb, :controller

  alias JewelryStore.Authentication
  alias JewelryStore.Users

  action_fallback JewelryStore.FallbackController

  def create(conn, params) do
    with {:ok, %{id: id, name: name, nickname: nickname}} <- Users.create_user(params),
         {:ok, token} <- Authentication.generate_refresh_token(%{id: id}) do
      %{token: token, name: name, nickname: nickname}
      |> render_response(conn, :created)
    end
  end
end
