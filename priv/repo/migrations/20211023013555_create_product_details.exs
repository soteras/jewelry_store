defmodule JewelryStore.Repo.Migrations.CreateProductDetails do
  use Ecto.Migration

  def change do
    create table(:product_details) do
      add :type, :string, null: false
      add :value, :string, null: false
      add :product_id, references(:products, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:product_details, [:product_id])
  end
end
