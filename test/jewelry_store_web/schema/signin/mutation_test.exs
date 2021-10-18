defmodule JewelryStoreWeb.Schema.Signin.MutationTest do
  use JewelryStoreWeb.ConnCase, async: true

  @signin_query """
  mutation signinInput($username: String!, $password: String!) {
    signin(input: {username: $username, password: $password}) {
      name
      nickname
      token
    }
  }
  """

  @params %{
    username: "test@gmail.com",
    password: "abc12345"
  }

  test "signin", %{conn: conn} do
    insert(:user, email: "test@gmail.com")

    response =
      conn
      |> post("/public/api", %{
        "query" => @signin_query,
        "variables" => @params
      })

    assert data = json_response(response, 200)

    assert get_data(data, "signin", "name") == "Maria da Silva"
    assert get_data(data, "signin", "nickname") == "Mari"
    assert byte_size(get_data(data, "signin", "token")) > 0
  end

  test "returns an error", %{conn: conn} do
    response =
      conn
      |> post("/public/api", %{
        "query" => @signin_query,
        "variables" => %{@params | username: "wrong_email@gmail.com"}
      })

    assert data = json_response(response, 200)

    [error] = get_errors(data)

    assert error["message"] == "E-mail ou CPF ou senha inválidos"
  end
end
