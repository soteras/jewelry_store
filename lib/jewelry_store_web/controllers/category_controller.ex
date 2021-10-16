defmodule JewelryStoreWeb.CategoryController do
  use JewelryStoreWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias JewelryStoreWeb.Swagger.{CategorySchema, Security}
  alias JewelryStore.Products

  action_fallback JewelryStore.FallbackController

  tags(["products"])
  security(Security.private())

  operation(:create,
    request_body:
      {"Payload de criação de categoria", "application/json", CategorySchema.CategoryRequest},
    responses: [
      created: {"Payload de resposta", "application/json", CategorySchema.CategoryResponse}
    ]
  )

  def create(conn, params) do
    with user <- current_resource(conn),
         :ok <- Bodyguard.permit(Products, :create, user),
         {:ok, %{name: name, slug: slug, active: active}} <- Products.create_category(params) do
      %{name: name, slug: slug, active: active}
      |> render_response(conn, :created)
    end
  end
end
