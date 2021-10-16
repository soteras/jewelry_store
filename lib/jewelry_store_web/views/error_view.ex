defmodule JewelryStoreWeb.ErrorView do
  use JewelryStoreWeb, :view

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: %Ecto.Changeset{} = changeset}) do
    %{
      error: %{
        details: translate_errors(changeset)
      }
    }
  end
end
