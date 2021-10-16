defmodule JewelryStore.Authentication.Guardian do
  use Guardian, otp_app: :jewelry_store

  alias JewelryStore.Users

  def subject_for_token(%{id: id}, _claims) do
    user_id = to_string(id)
    {:ok, user_id}
  end

  def subject_for_token(_, _) do
    {:error, :error_to_generate_token}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Users.get_user_by_id(id) do
      {:ok, user} ->
        {:ok, user}

      {:error, "not found"} ->
        {:error, :user_not_found}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :error_to_get_user_id}
  end
end
