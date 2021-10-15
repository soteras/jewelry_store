use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :jewelry_store, JewelryStore.Repo,
  username: "store_user",
  password: "store_password",
  database: "store_test",
  hostname: "localhost",
  port: System.get_env("DB_PORT", "5433") |> String.to_integer(),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jewelry_store, JewelryStoreWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
