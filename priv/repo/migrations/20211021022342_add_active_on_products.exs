defmodule JewelryStore.Repo.Migrations.AddActiveOnProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :active, :boolean, null: false, default: false
    end
  end
end
