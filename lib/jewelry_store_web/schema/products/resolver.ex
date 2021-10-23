defmodule JewelryStoreWeb.Schema.Category.Resolver do
  alias JewelryStore.Products
  alias JewelryStore.Products.Product

  def create_product(_parent, %{input: input}, %{context: %{current_user: current_user}}) do
    with :ok <- Bodyguard.permit(Products, :create, current_user),
         {:ok, product} <- Products.create_product(input) do
      {:ok, Product.from_struct(product)}
    end
  end
end
