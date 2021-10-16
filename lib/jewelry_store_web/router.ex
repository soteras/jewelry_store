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

  scope "/public/v1", JewelryStoreWeb do
    pipe_through :api
  end

  scope "/v1", JewelryStoreWeb do
    pipe_through [:auth, :api]
  end
end
