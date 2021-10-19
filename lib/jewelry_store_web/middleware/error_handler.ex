defmodule JewelryStoreWeb.Middleware.ErrorHandler do
  @behaviour Absinthe.Middleware

  alias JewelryStoreWeb.ErrorHelpers

  @impl true
  def call(resolution, _config) do
    if length(resolution.errors) > 0 do
      errors =
        resolution.errors
        |> List.first()
        |> ErrorHelpers.handle()

      %{resolution | errors: errors}
    else
      resolution
    end
  end
end
