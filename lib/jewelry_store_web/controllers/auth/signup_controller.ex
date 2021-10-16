defmodule JewelryStoreWeb.Auth.SignupController do
  use JewelryStoreWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias JewelryStore.Authentication
  alias JewelryStore.Users
  alias JewelryStoreWeb.Swagger.{Security, SignupSchema}

  action_fallback JewelryStore.FallbackController

  tags(["auth"])
  security(Security.public())

  operation(:create,
    request_body: {"Payload de criação", "application/json", SignupSchema.SignupRequest},
    responses: [
      created: {"Payload de resposta", "application/json", SignupSchema.SignupResponse}
    ]
  )

  def create(conn, params) do
    with {:ok, %{id: id, name: name, nickname: nickname}} <- Users.create_user(params),
         {:ok, token} <- Authentication.generate_refresh_token(%{id: id}) do
      %{token: token, name: name, nickname: nickname}
      |> render_response(conn, :created)
    end
  end
end
