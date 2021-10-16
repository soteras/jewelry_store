defmodule JewelryStoreWeb.CategoryControllerTest do
  use JewelryStoreWeb.ConnCase, async: true

  setup %{conn: conn} do
    user = insert(:user, admin: true)
    conn = login(conn, user)

    %{conn: conn}
  end

  describe "POST: creates category" do
    test "returns category", %{conn: conn} do
      response =
        conn
        |> post("/v1/categories", %{name: "Brincos Ear cuff, Jaquet e Hook", active: true})

      assert data = json_response(response, 201)

      assert get_data(data, "name") == "Brincos Ear cuff, Jaquet e Hook"
      assert get_data(data, "slug") == "brincos-ear-cuff-jaquet-e-hook"
      assert get_data(data, "active")
    end

    test "returns an error", %{conn: conn} do
      response =
        conn
        |> post("/v1/categories", %{name: ""})

      assert json_response(response, 422)
    end
  end

  describe "Patch: updates category" do
    setup do
      category = insert(:category, name: "Brincos de Argolas")

      %{category: category}
    end

    test "with success", %{conn: conn, category: category} do
      response =
        conn
        |> patch("/v1/categories/#{category.id}", %{name: "Brincos com Zircônias"})

      assert data = json_response(response, 200)

      assert get_data(data, "name") == "Brincos com Zircônias"
    end

    test "with error", %{conn: conn, category: category} do
      response =
        conn
        |> patch("/v1/categories/#{category.id}", %{name: ""})

      assert json_response(response, 422)
    end

    test "when not exist", %{conn: conn} do
      response =
        conn
        |> patch("/v1/categories/1", %{})

      assert json_response(response, 404)
    end
  end
end
