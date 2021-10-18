defmodule JewelryStoreWeb.Middleware.ErrorHandler do
  @behaviour Absinthe.Middleware

  alias JewelryStoreWeb.Utils.Error

  @impl true
  def call(resolution, _config) do
    errors =
      resolution.errors
      |> List.first()
      |> Error.handle()

    %{resolution | errors: errors}
  end
end
