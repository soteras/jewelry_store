defmodule JewelryStore.Authorization.Policies.Admin do
  @behaviour Bodyguard.Policy

  def authorize(action, %{admin: true}, _target)
      when action in [:list, :show, :create, :update, :delete],
      do: true

  def authorize(_, _, _), do: false
end
