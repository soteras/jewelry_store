alias JewelryStore.Repo
alias JewelryStore.Users.User
alias JewelryStore.Products.Category

%User{}
|> User.changeset(%{
  name: "Usuário teste",
  cpf: "86838272083",
  gender: "MALE",
  cellphone: "(11) 98999-9999",
  email: "test@gmail.com",
  password: "abc12345",
  password_confirmation: "abc12345",
  nickname: "Teste"
})
|> Repo.insert!()

%User{
  name: "Usuário admin",
  cpf: "39566169019",
  gender: "MALE",
  cellphone: "(11) 98999-9999",
  email: "admin@gmail.com",
  nickname: "Admin",
  password_hash: Bcrypt.hash_pwd_salt("abc12345"),
  admin: true
}
|> Repo.insert!()

%Category{}
|> Category.changeset(%{name: "Brincos Pequenos", active: true})
|> Repo.insert!()

%Category{}
|> Category.changeset(%{name: "Conjuntos com Zircônias", active: true})
|> Repo.insert!()
