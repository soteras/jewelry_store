defmodule JewelryStoreWeb.ErrorHelpers do
  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(JewelryStoreWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(JewelryStoreWeb.Gettext, "errors", msg, opts)
    end
  end

  def handle(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&translate_error/1)
    |> Enum.map(fn {k, v} ->
      %{field: k, message: List.first(v)}
    end)
  end

  def handle(error) do
    [%{message: error}]
  end
end
