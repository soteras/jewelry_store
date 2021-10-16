defmodule JewelryStoreWeb.CategoryControllerTest do
  use JewelryStoreWeb.ConnCase, async: true

  setup %{conn: conn} do
    user = insert(:user, admin: true)
    conn = login(conn, user)

    %{conn: conn}
  end

  describe "POST" do
    test "create category", %{conn: conn} do
      params = %{name: "Brincos Ear cuff, Jaquet e Hook", active: true}

      response =
        conn
        |> post("/v1/categories", params)

      assert data = json_response(response, 201)

      assert get_data(data, "name") == "Brincos Ear cuff, Jaquet e Hook"
      assert get_data(data, "slug") == "brincos-ear-cuff-jaquet-e-hook"
      assert get_data(data, "active")
    end

    test "returns an error", %{conn: conn} do
      params = %{name: ""}

      response =
        conn
        |> post("/v1/categories", params)

      assert json_response(response, 422)
    end
  end
end
