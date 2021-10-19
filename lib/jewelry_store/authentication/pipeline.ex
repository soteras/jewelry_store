defmodule JewelryStore.Authentication.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :jewelry_store,
    error_handler: JewelryStore.Authentication.ErrorHandler,
    module: JewelryStore.Authentication.Guardian

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
end
