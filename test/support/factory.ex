defmodule JewelryStore.Factory do
  use ExMachina.Ecto, repo: JewelryStore.Repo

  def user_factory(attrs) do
    cpf = Map.get(attrs, :cpf, "92785663063")
    attrs = Map.delete(attrs, :cpf)

    user = %JewelryStore.Users.User{
      name: "Maria da Silva",
      cpf: Brcpfcnpj.cpf_format(%Cpf{number: cpf}),
      rg: "273394721",
      gender: "female",
      nickname: "Mari",
      birthdate: ~D[2021-10-15],
      cellphone: "(11) 98999-9999",
      email: "mari@gmail.com",
      password_hash: Bcrypt.hash_pwd_salt("abc12345")
    }

    user
    |> merge_attributes(attrs)
    |> evaluate_lazy_attributes()
  end
end
