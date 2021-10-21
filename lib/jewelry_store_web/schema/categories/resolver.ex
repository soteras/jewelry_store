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

  def get_categories(_parent, _args, %{context: %{current_user: current_user}}) do
    with :ok <- Bodyguard.permit(Products, :list, current_user),
         {:ok, categories} <- Products.list_categories() do
      {:ok, Enum.map(categories, &build_category/1)}
    end
  end

  defp build_category(category) do
    %{name: category.name, active: category.active, slug: category.slug}
  end
end
