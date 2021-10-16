defmodule JewelryStoreWeb.Auth.SigninController do
  use JewelryStoreWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias JewelryStore.Authentication
  alias JewelryStoreWeb.Gettext
  alias JewelryStoreWeb.Swagger.{Security, SigninSchema}

  action_fallback JewelryStore.FallbackController

  tags(["auth"])
  security(Security.public())

  operation(:create,
    request_body: {"Payload de login", "application/json", SigninSchema.SigninRequest},
    responses: [
      ok: {"Payload de resposta", "application/json", SigninSchema.SigninResponse}
    ]
  )

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
    do: {:error, Gettext.dgettext("errors", "Email or password is invalid")}

  defp handle_response(response), do: response
end
