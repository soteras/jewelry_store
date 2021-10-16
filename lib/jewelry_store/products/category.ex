defmodule JewelryStore.Products.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias JewelryStore.Types.{DowncaseString, TrimmedString}

  @required_fields [:name, :active]

  schema "categories" do
    field :name, TrimmedString
    field :slug, DowncaseString
    field :active, :boolean, default: false

    timestamps()
  end

  def changeset(%__MODULE__{} = struct, attrs) do
    struct
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
    |> slugify_name()
    |> unique_constraint(:slug)
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
