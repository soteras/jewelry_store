defmodule JewelryStoreWeb.Schema.Signin.Resolver do
  alias JewelryStore.Authentication

  import JewelryStoreWeb.Gettext

  def signin(_parent, args, _context) do
    with %{username: username, password: password} <- Map.get(args, :input),
         {:ok, %{name: name, nickname: nickname}, token} <-
           Authentication.authenticate(username, password) do
      {:ok, %{token: token, name: name, nickname: nickname}}
    else
      _ ->
        {:error, dgettext("errors", "Username is invalid")}
    end
  end
end
