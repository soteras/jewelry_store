defmodule JewelryStore.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias JewelryStore.Products.Category
  alias JewelryStore.Types.{DowncaseString, TrimmedString}

  @required_fields [:name, :sku, :price, :short_description, :description, :category_id]

  schema "products" do
    field :name, TrimmedString
    field :slug, DowncaseString
    field :sku, TrimmedString
    field :price, Money.Ecto.Amount.Type
    field :short_description, TrimmedString
    field :description, TrimmedString

    belongs_to :category, Category

    timestamps()
  end

  def changeset(%__MODULE__{} = struct, attrs) do
    struct
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
    |> slugify_name
    |> unique_constraint(:slug)
    |> unique_constraint(:sku)
    |> assoc_constraint(:category)
  end

  defp slugify_name(changeset) do
    case changeset do
      %Ecto.Changeset{changes: %{name: name}} ->
        put_change(changeset, :slug, Slug.slugify(name))

      _ ->
        changeset
    end
  end
end
