defmodule JewelryStoreWeb.Swagger.SignupSchema do
  alias OpenApiSpex.Schema

  defmodule Request do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Atributos para criar um novo usuário",
      type: :object,
      properties: %{
        name: %Schema{type: :string, description: "Nome completo"},
        email: %Schema{type: :string, description: "Email", format: :email},
        nickname: %Schema{type: :string, description: "Como gostaria de ser chamado"},
        birthdate: %Schema{type: :string, description: "Data de nascimento", format: :date},
        cellphone: %Schema{type: :string, description: "Celular"},
        cpf: %Schema{type: :string, description: "CPF"},
        rg: %Schema{type: :string, description: "RG"},
        gender: %Schema{type: :string, description: "Gênero", enum: ["female", "male", "other"]},
        password: %Schema{type: :string, description: "Senha", format: :password},
        password_confirmation: %Schema{
          type: :string,
          description: "Confirmação da senha",
          format: :password
        }
      },
      required: [:name, :cpf, :gender, :cellphone, :email, :password, :password_confirmation],
      example: %{
        "name" => "Maria da Silva",
        "email" => "maria@gmail.com",
        "nickname" => "Mari",
        "birthdate" => "1994-09-23",
        "cellphone" => "(11) 11111-1111",
        "cpf" => "11111111111",
        "rg" => "111111111",
        "gender" => "male",
        "password" => "abc12345",
        "password_confirmation" => "abc12345"
      }
    })
  end

  defmodule Response do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Resposta do signup",
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
