defmodule JewelryStore.Swagger.ApiSpec do
  alias OpenApiSpex.{Components, Info, OpenApi, Paths, SecurityScheme, Server}
  alias JewelryStoreWeb.{Endpoint, Router}

  @behaviour OpenApi

  @impl OpenApi
  def spec do
    %OpenApi{
      components: %Components{
        securitySchemes: %{
          "authorization" => %SecurityScheme{
            type: "http",
            scheme: "bearer"
          }
        }
      },
      servers: [
        Server.from_endpoint(Endpoint)
      ],
      info: %Info{
        title: "Jewelry Store API",
        version: "V1"
      },
      paths: Paths.from_router(Router)
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
