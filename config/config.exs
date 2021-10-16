use Mix.Config

config :jewelry_store,
  ecto_repos: [JewelryStore.Repo]

config :jewelry_store, JewelryStoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/ghkn+UCw/iLLgvLOr0MMuwIH/yWUy6WQhFFYyUo/BHTGr4M+B+FWG1LFItBZzaG",
  render_errors: [view: JewelryStoreWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: JewelryStore.PubSub,
  live_view: [signing_salt: "aM0g+9Xr"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :jewelry_store, JewelryStore.Authentication.Guardian,
  issuer: "jewelry_store",
  secret_key: "R4+b8vO3wZjyxSQbGfd0g2llE0zamq69iDX9ihP4uFl+nF5fD3BzFmKri4uFnGkZ"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
