defmodule JewelryStoreWeb.CategoryController do
  use JewelryStoreWeb, :controller

  alias JewelryStore.Products

  action_fallback JewelryStore.FallbackController

  def create(conn, params) do
    with user <- current_resource(conn),
         :ok <- Bodyguard.permit(Products, :create, user),
         {:ok, category} <- Products.create_category(params) do
      category
      |> handle_detail()
      |> render_response(conn, :created)
    end
  end

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
