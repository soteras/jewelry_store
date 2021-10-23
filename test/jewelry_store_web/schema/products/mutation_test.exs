defmodule JewelryStoreWeb.Schema.Products.MutationTest do
  use JewelryStoreWeb.ConnCase, async: true

  @create_product_query """
  mutation createProductInput($name: String!, $sku: String!, $price: Int!, $shortDescription: String!, $description: String!, $categoryId: Int!, $quantity: Int, $active: Boolean) {
    createProduct(input: {name: $name, sku: $sku, price: $price, shortDescription: $shortDescription, description: $description, categoryId: $categoryId, quantity: $quantity, active: $active}) {
      name
      sku
      price
      shortDescription
      description
      quantity
      active
      slug
    }
  }
  """

  @params %{
    name: "Pulseira Estilo Bracelete Fio Love Semijoias Antialérgicas Banhadas a Ouro 22k",
    sku: "PL745",
    price: 9990,
    shortDescription:
      "Pulseira estilo bracelete fio Love, semijoia antialérgica banhada a ouro 22k.",
    description:
      "Pulseira estilo bracelete fio liso com escrita LOVE. Tamanho aproximado: 5,8 cm de diâmetro. Semijoia antialérgica banhada  a ouro 22k. Direto de fábrica em Limeira.",
    categoryId: 1,
    quantity: 23,
    active: true
  }

  describe "mutation: createProduct" do
    test "create product", %{conn: conn} do
      user = insert(:user, admin: true)
      category = insert(:category)

      response =
        conn
        |> login(user)
        |> post("/api", %{
          "query" => @create_product_query,
          "variables" => %{@params | categoryId: category.id}
        })

      assert data = json_response(response, 200)

      assert get_data(data, "createProduct", "name") ==
               "Pulseira Estilo Bracelete Fio Love Semijoias Antialérgicas Banhadas a Ouro 22k"

      assert get_data(data, "createProduct", "slug") ==
               "pulseira-estilo-bracelete-fio-love-semijoias-antialergicas-banhadas-a-ouro-22k"

      assert get_data(data, "createProduct", "sku") == "PL745"
      assert get_data(data, "createProduct", "price") == 9990

      assert get_data(data, "createProduct", "shortDescription") ==
               "Pulseira estilo bracelete fio Love, semijoia antialérgica banhada a ouro 22k."

      assert get_data(data, "createProduct", "description") ==
               "Pulseira estilo bracelete fio liso com escrita LOVE. Tamanho aproximado: 5,8 cm de diâmetro. Semijoia antialérgica banhada  a ouro 22k. Direto de fábrica em Limeira."

      assert get_data(data, "createProduct", "quantity") == 23
      assert get_data(data, "createProduct", "active")
    end

    test "forbidden for not admin user", %{conn: conn} do
      user = insert(:user, admin: false)

      response =
        conn
        |> login(user)
        |> post("/api", %{
          "query" => @create_product_query,
          "variables" => @params
        })

      assert data = json_response(response, 200)

      [error] = get_errors(data)

      assert error["message"] == "unauthorized"
    end
  end
end
