defmodule JewelryStore.Authorization.Policies.User do
  @behaviour Bodyguard.Policy

  def authorize(action, %{id: user_id}, %{user_id: user_id})
      when action in [:show, :update, :delete],
      do: true

  def authorize(action, _user, _target) when action in [:list, :create], do: true

  def authorize(_, _, _), do: false
end
