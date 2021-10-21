alias JewelryStore.Repo
alias JewelryStore.Users.User
alias JewelryStore.Products.Category
alias JewelryStore.Products.Product

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

category1 =
  %Category{}
  |> Category.changeset(%{name: "Brincos Pequenos", active: true})
  |> Repo.insert!()

category2 =
  %Category{}
  |> Category.changeset(%{name: "Conjuntos com Zircônias", active: true})
  |> Repo.insert!()

%Product{}
|> Product.changeset(%{
  name: "Brinco Fixo Lua Decorada Vazada Semijoias Antiaérgicas Banhadas a Ouro 22k",
  sku: "BR1925",
  price: 2499,
  short_description: "Brinco fixo lua decorada vazada, semijoia antialérgica banhada a ouro 22k",
  description: "Brinco fixo lua decorada vazada, semijoia antialérgica banhada a ouro 22k",
  quantity: 8,
  active: true,
  category_id: category1.id
})
|> Repo.insert!()

%Product{}
|> Product.changeset(%{
  name: "Brinco Fixo Gota Pequena Abaulada Lisa Semijoias Antialérgicas Banhadas a Ouro 22k",
  sku: "BR1923",
  price: 3299,
  short_description:
    "Brinco fixo gota pequena abaulada lisa,  semijoia antialérgica banhada a ouro 22k.",
  description:
    "Brinco fixo gota pequena abaulada lisa,  semijoia antialérgica banhada a ouro 22k.",
  quantity: 1,
  active: true,
  category_id: category1.id
})
|> Repo.insert!()

%Product{}
|> Product.changeset(%{
  name:
    "Conjunto Coração Microzircônias Pink e Ródio Negro Semijoias Antialérgicas Banhados a Ouro 22K",
  sku: "CJ355_Pink",
  price: 17219,
  short_description:
    "Conjunto coração microzircônias pink e ródio negro, semijoias antialérgica banhada a ouro 22K",
  description:
    "Conjunto coração microzircônias pink e ródio negro, semijoias antialérgica banhada a ouro 22K",
  quantity: 11,
  active: true,
  category_id: category2.id
})
|> Repo.insert!()
