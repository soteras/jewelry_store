defmodule JewelryStore.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false
      add :slug, :string, null: false
      add :active, :boolean, null: false, default: false

      timestamps()
    end

    create unique_index(:categories, [:name])
    create unique_index(:categories, [:slug])
  end
end
