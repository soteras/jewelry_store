defmodule JewelryStoreWeb.Schema.Signup.MutationTest do
  use JewelryStoreWeb.ConnCase, async: true

  @signup_query """
  mutation userInput($name: String!, $cpf: String!, $email: String!, $gender: Gender!, $password: String!, $passwordConfirmation: String!, $cellphone: String!, $nickname: String!) {
    createUser(input: {name: $name, cpf: $cpf, email: $email, gender: $gender, password: $password, passwordConfirmation: $passwordConfirmation, cellphone: $cellphone, nickname: $nickname}) {
      name
      nickname
      token
    }
  }
  """

  @params %{
    name: "Antonio Carlos",
    cpf: "09986414059",
    gender: "MALE",
    cellphone: "(11) 98999-9999",
    email: "antonio@gmail.com",
    password: "abc12345",
    passwordConfirmation: "abc12345",
    nickname: "Antony"
  }

  test "create new user", %{conn: conn} do
    response =
      conn
      |> post("/public/api", %{
        "query" => @signup_query,
        "variables" => @params
      })

    assert data = json_response(response, 200)

    assert get_data(data, "createUser", "name") == "Antonio Carlos"
    assert get_data(data, "createUser", "nickname") == "Antony"
    assert byte_size(get_data(data, "createUser", "token")) > 0
  end

  test "returns an error", %{conn: conn} do
    response =
      conn
      |> post("/public/api", %{
        "query" => @signup_query,
        "variables" => %{@params | name: ""}
      })

    assert data = json_response(response, 200)

    [error] = get_errors(data)

    assert error["message"] == "não pode ficar em branco"
  end
end
