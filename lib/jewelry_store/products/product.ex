defmodule JewelryStore.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias JewelryStore.Products.Category
  alias JewelryStore.Products.ProductDetail
  alias JewelryStore.Types.{DowncaseString, TrimmedString}

  @required_fields [:name, :sku, :price, :short_description, :description, :category_id]
  @optional_fields [:quantity, :active]

  schema "products" do
    field :name, TrimmedString
    field :slug, DowncaseString
    field :sku, TrimmedString
    field :price, Money.Ecto.Amount.Type
    field :short_description, TrimmedString
    field :description, TrimmedString
    field :quantity, :integer, default: 0
    field :active, :boolean, default: false

    belongs_to :category, Category
    has_many :product_details, ProductDetail

    timestamps()
  end

  def changeset(%__MODULE__{} = struct, attrs) do
    struct
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
    |> slugify_name
    |> unique_constraint(:slug)
    |> unique_constraint(:sku)
    |> validate_number(:quantity, greater_than_or_equal_to: 0)
    |> assoc_constraint(:category)
    |> cast_assoc(:product_details, with: &ProductDetail.changeset/2)
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
