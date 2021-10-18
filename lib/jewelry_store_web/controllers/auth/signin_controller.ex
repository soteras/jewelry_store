defmodule JewelryStoreWeb.Auth.SigninController do
  use JewelryStoreWeb, :controller

  alias JewelryStore.Authentication
  alias JewelryStoreWeb.Gettext

  action_fallback JewelryStore.FallbackController

  def create(conn, %{"username" => username, "password" => password}) do
    response =
      username
      |> Authentication.authenticate(password)
      |> handle_response()

    with {:ok, %{name: name, nickname: nickname}, token} <- response do
      %{token: token, name: name, nickname: nickname}
      |> render_response(conn)
    end
  end

  defp handle_response({:error, _}),
    do: {:error, Gettext.dgettext("errors", "Username is invalid")}

  defp handle_response(response), do: response
end
