defmodule JewelryStoreWeb.Auth.SignupControllerTest do
  use JewelryStoreWeb.ConnCase, async: true

  describe "POST" do
    test "create new user", %{conn: conn} do
      params = %{
        name: "Antonio Carlos",
        cpf: "09986414059",
        rg: "273394721",
        gender: "male",
        nickname: "Antony",
        birthdate: "2021-10-15",
        cellphone: "(11) 98999-9999",
        email: "antonio@gmail.com",
        password: "abc12345",
        password_confirmation: "abc12345"
      }

      response =
        conn
        |> post("/public/v1/signup", params)

      assert data = json_response(response, 201)

      assert get_data(data, "name") == "Antonio Carlos"
      assert get_data(data, "nickname") == "Antony"
      assert byte_size(get_data(data, "token")) > 0
    end

    test "error to create user", %{conn: conn} do
      params = %{
        name: "Antonio Carlos"
      }

      response =
        conn
        |> post("/public/v1/signup", params)

      assert json_response(response, 422)
    end
  end
end
