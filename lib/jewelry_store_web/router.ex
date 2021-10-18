defmodule JewelryStoreWeb.Router do
  use JewelryStoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug JewelryStore.Authentication.Pipeline
  end

  scope "/public/api" do
    pipe_through :api

    if Mix.env() == :dev do
      forward "/graphiql", JewelryStoreWeb.Plug.PublicGraphiql,
        schema: JewelryStoreWeb.PublicSchema
    end

    forward "/", JewelryStoreWeb.Plug.PublicAbsinthe, schema: JewelryStoreWeb.PublicSchema
  end

  scope "/api" do
    pipe_through [:api, :auth]

    resources "/categories", JewelryStoreWeb.CategoryController, only: [:create, :update]

    forward "/", JewelryStoreWeb.Plug.Absinthe, schema: JewelryStoreWeb.Schema
  end
end
