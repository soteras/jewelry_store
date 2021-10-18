defmodule JewelryStoreWeb.Middleware.ErrorHandler do
  @behaviour Absinthe.Middleware

  alias JewelryStoreWeb.Utils.Error

  @impl true
  def call(resolution, _config) do
    if length(resolution.errors) > 0 do
      errors =
        resolution.errors
        |> List.first()
        |> Error.handle()

      %{resolution | errors: errors}
    else
      resolution
    end
  end
end
