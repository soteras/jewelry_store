defmodule JewelryStoreWeb.Schema.Signup.Type do
  use Absinthe.Schema.Notation

  import_types(Absinthe.Type.Custom)

  object :session do
    field :name, :string
    field :nickname, :string
    field :token, :string
  end

  enum :gender do
    description("Tipos de gêneros")

    value(:female, as: "female", description: "Feminino")
    value(:male, as: "male", description: "Masculino")
    value(:other, as: "other", description: "Outro")
  end

  input_object :signup_input do
    description("Campos da criação do usuário")

    field :name, non_null(:string), description: "Nome"
    field :cpf, non_null(:string), description: "CPF"
    field :gender, non_null(:gender), description: "Gênero"
    field :cellphone, non_null(:string), description: "Número de celular"
    field :email, non_null(:string), description: "E-mail"
    field :password, non_null(:string), description: "Senha"
    field :password_confirmation, non_null(:string), description: "Confirmação da senha"
    field :rg, :string, description: "RG"
    field :nickname, :string, description: "Apelido"
    field :birthdate, :date, description: "Data de aniversário"
  end
end
