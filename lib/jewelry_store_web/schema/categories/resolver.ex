defmodule JewelryStoreWeb.Schema.Categories.Resolver do
  alias JewelryStore.Products

  def create_category(_parent, args, %{context: %{current_user: current_user}}) do
    with :ok <- Bodyguard.permit(Products, :create, current_user),
         input <- Map.get(args, :input),
         {:ok, %{name: name, active: active, slug: slug}} <- Products.create_category(input) do
      {:ok, %{name: name, active: active, slug: slug}}
    end
  end

  def update_category(_parent, %{id: id, input: input}, %{context: %{current_user: current_user}}) do
    with :ok <- Bodyguard.permit(Products, :update, current_user),
         {:ok, category} <- Products.get_category_by_id(id),
         {:ok, %{name: name, active: active, slug: slug}} <-
           Products.update_category(category, input) do
      {:ok, %{name: name, active: active, slug: slug}}
    end
  end
end
