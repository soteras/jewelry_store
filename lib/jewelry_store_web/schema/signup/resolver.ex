defmodule JewelryStoreWeb.Schema.Signup.Resolver do
  alias JewelryStore.Authentication
  alias JewelryStore.Users

  def create_post(_parent, args, _context) do
    with input <- Map.get(args, :input),
         {:ok, %{id: id, name: name, nickname: nickname}} <- Users.create_user(input),
         {:ok, token} <- Authentication.generate_refresh_token(%{id: id}) do
      {:ok, %{token: token, name: name, nickname: nickname}}
    end
  end
end
