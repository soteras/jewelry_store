defmodule JewelryStore.Factory do
  use ExMachina.Ecto, repo: JewelryStore.Repo

  def user_factory do
    %JewelryStore.Users.User{
      name: "Maria da Silva",
      cpf: "09986414059",
      rg: "273394721",
      gender: "female",
      nickname: "Mari",
      birthdate: ~D[2021-10-15],
      cellphone: "(11) 98999-9999",
      email: "maria@gmail.com"
    }
  end
end
