defmodule JewelryStoreWeb.Auth.SigninControllerTest do
  use JewelryStoreWeb.ConnCase, async: true

  describe "POST" do
    setup do
      insert(:user, email: "test@gmail.com", cpf: "72652408046")

      :ok
    end

    test "login user by email", %{conn: conn} do
      params = %{username: "test@gmail.com", password: "abc12345"}

      response =
        conn
        |> post("/public/api/signin", params)

      assert data = json_response(response, 200)

      assert get_data(data, "name") == "Maria da Silva"
      assert get_data(data, "nickname") == "Mari"
      assert byte_size(get_data(data, "token")) > 0
    end

    test "login user by cpf", %{conn: conn} do
      params = %{username: "72652408046", password: "abc12345"}

      response =
        conn
        |> post("/public/api/signin", params)

      assert data = json_response(response, 200)

      assert get_data(data, "name") == "Maria da Silva"
      assert get_data(data, "nickname") == "Mari"
      assert byte_size(get_data(data, "token")) > 0
    end

    test "user is not found", %{conn: conn} do
      params = %{username: "wrong_email@gmail.com", password: "abc12345"}

      response =
        conn
        |> post("/public/api/signin", params)

      assert data = json_response(response, 422)

      assert get_errors(data) == ["E-mail ou CPF ou senha inválidos"]
    end

    test "password is wrong", %{conn: conn} do
      params = %{username: "test@gmail.com", password: "123"}

      response =
        conn
        |> post("/public/api/signin", params)

      assert data = json_response(response, 422)

      assert get_errors(data) == ["E-mail ou CPF ou senha inválidos"]
    end
  end
end
