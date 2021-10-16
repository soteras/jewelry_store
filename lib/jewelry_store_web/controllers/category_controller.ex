defmodule JewelryStoreWeb.CategoryController do
  use JewelryStoreWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias JewelryStore.Products
  alias JewelryStoreWeb.Swagger.{CategorySchema, Security}
  alias OpenApiSpex.Schema

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
         {:ok, category} <- Products.create_category(params) do
      category
      |> handle_detail()
      |> render_response(conn, :created)
    end
  end

  operation(:update,
    parameters: [
      id: [
        in: :query,
        type: %Schema{type: :integer, minimum: 1},
        description: "ID da categoria",
        example: 1,
        required: true
      ]
    ],
    request_body:
      {"Payload de atualização de categoria", "application/json", CategorySchema.CategoryRequest},
    responses: [
      ok: {"Payload de resposta", "application/json", CategorySchema.CategoryResponse}
    ]
  )

  def update(conn, %{"id" => id} = params) do
    with user <- current_resource(conn),
         :ok <- Bodyguard.permit(Products, :update, user),
         {:ok, category} <- Products.get_category_by_id(id),
         {:ok, category} <- Products.update_category(category, params) do
      category
      |> handle_detail
      |> render_response(conn)
    end
  end

  defp handle_detail(%{name: name, slug: slug, active: active}),
    do: %{name: name, slug: slug, active: active}
end
