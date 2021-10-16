defmodule JewelryStore.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :cpf, :string, null: false, size: 14
      add :rg, :string
      add :gender, :string, null: false, default: "female"
      add :nickname, :string
      add :birthdate, :date
      add :cellphone, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:cpf])
  end
end
