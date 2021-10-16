defmodule JewelryStoreWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      import JewelryStoreWeb.ConnCase
      import JewelryStore.Factory

      alias JewelryStore.Authentication
      alias JewelryStoreWeb.Router.Helpers, as: Routes

      @endpoint JewelryStoreWeb.Endpoint

      def get_data(data, key), do: data["data"][key]
      def get_errors(data), do: data["error"]["details"]

      def login(conn, user) do
        case Authentication.generate_refresh_token(user) do
          {:ok, token} -> put_req_header(conn, "authorization", "Bearer #{token}")
          _ -> {:error, "Couldn't login"}
        end
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(JewelryStore.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(JewelryStore.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
