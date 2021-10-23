defmodule JewelryStore.Products.ProductDetail do
  use Ecto.Schema
  import Ecto.Changeset

  alias JewelryStore.Products.Product

  @required_fields [:type, :value]
  @optional_fields [:product_id]
  @types [
    "banho",
    "tamanho",
    "garantia"
  ]

  schema "product_details" do
    field :type, :string
    field :value, :string

    belongs_to :product, Product

    timestamps()
  end

  def changeset(%__MODULE__{} = struct, attrs) do
    struct
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:type, @types)
    |> assoc_constraint(:product)
  end
end
