defmodule JewelryStoreWeb.Plug.Context do
  @behaviour Plug

  alias JewelryStore.Authentication

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, current_user} <- Authentication.current_resource(token) do
      %{current_user: current_user}
    else
      _ -> %{}
    end
  end
end
