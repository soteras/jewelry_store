defmodule JewelryStoreWeb.Schema.Signup.Resolver do
  def create_post(_parent, args, _context) do
    IO.inspect(args)

    {:ok, %{name: "Carlos", nickname: "Soteras", token: "abc123"}}
  end
end
