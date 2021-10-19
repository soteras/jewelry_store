defmodule JewelryStoreWeb.Schema.Categories.Resolver do
  alias JewelryStore.Products

  def create_category(_parent, args, %{context: %{current_user: current_user}}) do
    with :ok <- Bodyguard.permit(Products, :create, current_user),
         input <- Map.get(args, :input),
         {:ok, %{name: name, active: active, slug: slug}} <- Products.create_category(input) do
      {:ok, %{name: name, active: active, slug: slug}}
    end
  end
end
