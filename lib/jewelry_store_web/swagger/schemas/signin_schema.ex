defmodule JewelryStoreWeb.Swagger.SigninSchema do
  alias OpenApiSpex.Schema

  defmodule SigninRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Atributos para logar um usuário",
      type: :object,
      properties: %{
        username: %Schema{type: :string, description: "Username pode ser email ou cpf"},
        password: %Schema{type: :string, description: "Senha", format: :password}
      },
      required: [:username, :password],
      example: %{
        "username" => "maria@gmail.com",
        "password" => "abc12345"
      }
    })
  end

  defmodule SigninResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Resposta do signin",
      type: :object,
      properties: %{
        token: %Schema{type: :string, description: "Token JWT"},
        name: %Schema{type: :string, description: "Nome do usuário"},
        nickname: %Schema{type: :string, description: "Nome como gostaria de ser chamado"}
      },
      example: %{
        "token" =>
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ",
        "name" => "Maria da Silva",
        "nickname" => "Mari"
      }
    })
  end
end
