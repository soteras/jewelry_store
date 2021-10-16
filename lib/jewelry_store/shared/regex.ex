defmodule JewelryStore.Shared.Regex do
  def email_regex, do: ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
end
