defmodule JewelryStore.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false, size: 25
      add :slug, :string, null: false

      timestamps()
    end

    create unique_index(:categories, [:name])
    create unique_index(:categories, [:slug])
  end
end
