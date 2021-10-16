defmodule JewelryStore.Swagger.Security do
  def public do
    []
  end

  def private do
    [
      %{"authorization" => []}
    ]
  end
end
