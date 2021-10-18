defmodule JewelryStoreWeb.Utils.Error do
  require Logger

  alias JewelryStoreWeb.ErrorHelpers

  def handle(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&ErrorHelpers.translate_error/1)
    |> Enum.map(fn {k, v} ->
      %{field: k, message: v}
    end)
  end

  def render(error) do
    %{field: "", message: error}
  end
end
