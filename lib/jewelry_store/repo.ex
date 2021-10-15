defmodule JewelryStore.Repo do
  use Ecto.Repo,
    otp_app: :jewelry_store,
    adapter: Ecto.Adapters.Postgres
end
