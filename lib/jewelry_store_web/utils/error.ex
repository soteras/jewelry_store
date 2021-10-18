defmodule JewelryStoreWeb.Utils.Error do
  require Logger

  alias JewelryStoreWeb.ErrorHelpers

  def handle(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&ErrorHelpers.translate_error/1)
    |> Enum.map(fn {k, v} ->
      %{field: k, message: List.first(v)}
    end)
  end

  def handle(error) do
    [%{message: error}]
  end
end
