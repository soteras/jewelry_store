defmodule JewelryStore.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string, null: false
      add :slug, :string, null: false
      add :sku, :string, null: false
      add :price, :integer, null: false
      add :short_description, :string, null: false
      add :description, :text, null: false
      add :category_id, references("categories"), null: false

      timestamps()
    end

    create index(:products, [:category_id])
    create unique_index(:products, [:title])
    create unique_index(:products, [:slug])
    create unique_index(:products, [:sku])
  end
end
