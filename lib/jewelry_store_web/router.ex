defmodule JewelryStoreWeb.Router do
  use JewelryStoreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", JewelryStoreWeb do
    pipe_through :api
  end
end
