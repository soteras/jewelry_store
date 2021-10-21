defmodule JewelryStoreWeb.Schema.Categories.QueryTest do
  use JewelryStoreWeb.ConnCase, async: true

  @get_categories_query """
  query {
    categories {
      name
      slug
      active
    }
  }
  """

  describe "query: getCategories" do
    test "get categories", %{conn: conn} do
      user = insert(:user, admin: true)
      insert(:category)

      response =
        conn
        |> login(user)
        |> post("/api", %{
          "query" => @get_categories_query
        })

      assert data = json_response(response, 200)

      assert get_data(data, "categories") == [
               %{"active" => true, "name" => "Aço Inox", "slug" => "aco-inox"}
             ]
    end

    test "forbidden for not admin user", %{conn: conn} do
      user = insert(:user, admin: false)

      response =
        conn
        |> login(user)
        |> post("/api", %{
          "query" => @get_categories_query
        })

      assert data = json_response(response, 200)

      [error] = get_errors(data)

      assert error["message"] == "unauthorized"
    end
  end
end
