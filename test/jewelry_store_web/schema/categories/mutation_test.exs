defmodule JewelryStoreWeb.Schema.Categories.ResolverTest do
  use JewelryStoreWeb.ConnCase, async: true

  @create_category_query """
  mutation createCategoryInput($name: String!, $active: Boolean!) {
    createCategory(input: {name: $name, active: $active}) {
      name
      slug
      active
    }
  }
  """

  @params %{
    name: "Brincos em aço Inox",
    active: true
  }

  describe "mutation: createCategory" do
    test "create category", %{conn: conn} do
      user = insert(:user, admin: true)

      response =
        conn
        |> login(user)
        |> post("/api", %{
          "query" => @create_category_query,
          "variables" => @params
        })

      assert data = json_response(response, 200)

      assert get_data(data, "createCategory", "name") == "Brincos em aço Inox"
      assert get_data(data, "createCategory", "slug") == "brincos-em-aco-inox"
      assert get_data(data, "createCategory", "active")
    end

    test "forbidden for not admin user", %{conn: conn} do
      user = insert(:user, admin: false)

      response =
        conn
        |> login(user)
        |> post("/api", %{
          "query" => @create_category_query,
          "variables" => @params
        })

      assert data = json_response(response, 200)

      [error] = get_errors(data)

      assert error["message"] == "unauthorized"
    end
  end
end
