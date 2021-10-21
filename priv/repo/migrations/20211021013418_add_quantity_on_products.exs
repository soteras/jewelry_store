defmodule JewelryStore.Repo.Migrations.AddQuantityOnProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :quantity, :integer, null: false, default: 0
    end
  end
end
