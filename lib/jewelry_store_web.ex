defmodule JewelryStoreWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: JewelryStoreWeb

      alias JewelryStoreWeb.Router.Helpers, as: Routes

      import Plug.Conn
      import JewelryStoreWeb.Gettext
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

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
