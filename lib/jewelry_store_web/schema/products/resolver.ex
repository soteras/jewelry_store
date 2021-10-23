defmodule JewelryStoreWeb.Schema.Category.Resolver do
  alias JewelryStore.Products
  alias JewelryStore.Products.Product

  def create_product(_parent, %{input: input}, %{context: %{current_user: current_user}}) do
    with :ok <- Bodyguard.permit(Products, :create, current_user),
         {:ok, product} <- Products.create_product(input) do
      {:ok, Product.from_struct(product)}
    end
  end

  def update_product(_parent, %{id: id, input: input}, %{context: %{current_user: current_user}}) do
    with :ok <- Bodyguard.permit(Products, :create, current_user),
         {:ok, product} <- Products.get_product_by_id(id),
         {:ok, product} <- Products.update_product(product, input) do
      {:ok, Product.from_struct(product)}
    end
  end
end
