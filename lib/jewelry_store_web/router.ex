defmodule JewelryStoreWeb.Router do
  use JewelryStoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api_swagger do
    plug OpenApiSpex.Plug.PutApiSpec, module: JupiterWeb.Swagger.ApiSpec
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug JewelryStore.Authentication.Pipeline
  end

  scope "/v1" do
    pipe_through :api_swagger

    get "/openapi", OpenApiSpex.Plug.RenderSpec, []
  end

  scope "/" do
    pipe_through :browser

    get "/swaggerui", OpenApiSpex.Plug.SwaggerUI, path: "/v1/openapi"
  end

  scope "/public/v1", JewelryStoreWeb do
    pipe_through :api
  end

  scope "/v1", JewelryStoreWeb do
    pipe_through [:auth, :api]
  end
end
