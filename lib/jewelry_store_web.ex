defmodule JewelryStoreWeb do
  alias JewelryStoreWeb.JewelryStoreView

  import Phoenix.Controller, only: [put_view: 2, render: 3]
  import Plug.Conn

  def controller do
    quote do
      use Phoenix.Controller, namespace: JewelryStoreWeb

      alias JewelryStoreWeb.Router.Helpers, as: Routes

      import Plug.Conn
      import JewelryStoreWeb.Gettext
      import JewelryStoreWeb, only: [render_response: 2, render_response: 3]
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/jewelry_store_web/templates",
        namespace: JewelryStoreWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import JewelryStoreWeb.Gettext
    end
  end

  defp view_helpers do
    quote do
      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import JewelryStoreWeb.ErrorHelpers
      import JewelryStoreWeb.Gettext
      alias JewelryStoreWeb.Router.Helpers, as: Routes
    end
  end

  @spec render_response(nil, Plug.Conn.t()) :: nil
  def render_response(nil, _conn), do: nil

  @spec render_response(map, Plug.Conn.t()) :: Plug.Conn.t()
  def render_response(%{data: data, pagination: pagination}, conn) do
    conn
    |> put_status(:ok)
    |> put_view(JewelryStoreView)
    |> render("paginated.json", %{data: data, pagination: pagination})
  end

  @spec render_response(atom, Plug.Conn.t()) :: Plug.Conn.t()
  def render_response(:empty, conn) do
    conn
    |> put_status(:ok)
    |> put_view(JewelryStoreView)
    |> render("response.json", data: :empty)
  end

  @spec render_response(map | list, Plug.Conn.t()) :: Plug.Conn.t()
  def render_response(data, conn) do
    conn
    |> put_status(:ok)
    |> put_view(JewelryStoreView)
    |> render("response.json", data: data)
  end

  @spec render_response(map | list, Plug.Conn.t(), atom) :: Plug.Conn.t()
  def render_response(data, conn, status) do
    conn
    |> put_status(status)
    |> put_view(JewelryStoreView)
    |> render("response.json", data: data)
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
