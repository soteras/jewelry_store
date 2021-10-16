defmodule JewelryStore.Factory do
  use ExMachina.Ecto, repo: JewelryStore.Repo

  def user_factory do
    %JewelryStore.Users.User{
      name: "Maria da Silva",
      cpf: "92785663063",
      rg: "273394721",
      gender: "female",
      nickname: "Mari",
      birthdate: ~D[2021-10-15],
      cellphone: "(11) 98999-9999",
      email: "mari@gmail.com",
      password_hash: Bcrypt.hash_pwd_salt("abc12345")
    }
  end
end
