defmodule JewelryStoreWeb.Swagger.CategorySchema do
  alias OpenApiSpex.Schema

  defmodule CategoryRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Atributos para request de categoria",
      type: :object,
      properties: %{
        name: %Schema{type: :string, description: "Nome"},
        active: %Schema{type: :boolean, description: "Ativo"}
      },
      required: [:name, :active],
      example: %{
        "name" => "Anéis de Profissão",
        "active" => true
      }
    })
  end

  defmodule CategoryResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Resposta da request de categoria",
      type: :object,
      properties: %{
        name: %Schema{type: :string, description: "Nome"},
        slug: %Schema{type: :string, description: "Slug"},
        active: %Schema{type: :boolean, description: "Ativo"}
      },
      example: %{
        "name" => "Anéis de Profissão",
        "slug" => "aneis-de-profissao",
        "active" => true
      }
    })
  end
end
