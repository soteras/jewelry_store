defmodule JewelryStore.Users.UserTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Repo
  alias JewelryStore.Users.User

  @attrs %{
    name: "Maria da Silva",
    cpf: "09986414059",
    rg: "273394721",
    gender: "female",
    nickname: "Mari",
    birthdate: ~D[2021-10-15],
    cellphone: "(11) 98999-9999",
    email: "maria@gmail.com",
    password: "abc12345",
    password_confirmation: "abc12345"
  }

  describe "changeset/2: valid attrs" do
    test "create changeset" do
      changeset = User.changeset(%User{}, @attrs)

      assert changeset.valid?
    end
  end

  describe "changeset/2: name" do
    test "is empty" do
      changeset = User.changeset(%User{}, %{@attrs | name: ""})

      assert get_error_message(changeset, :name) == "can't be blank"
    end
  end

  describe "changeset/2: cpf" do
    test "is empty" do
      changeset = User.changeset(%User{}, %{@attrs | cpf: ""})

      assert get_error_message(changeset, :cpf) == "can't be blank"
    end

    test "invalid format" do
      changeset = User.changeset(%User{}, %{@attrs | cpf: "11111111111"})

      assert get_error_message(changeset, :cpf) == "Invalid Cpf"
    end

    test "is not unique" do
      insert(:user, cpf: "15631640007")

      {:error, changeset} =
        %User{}
        |> User.changeset(%{@attrs | cpf: "15631640007"})
        |> Repo.insert()

      assert get_error_message(changeset, :cpf) == "has already been taken"
    end
  end

  describe "changeset/2: gender" do
    test "is not included" do
      changeset = User.changeset(%User{}, %{@attrs | gender: "cat"})

      assert get_error_message(changeset, :gender) == "is invalid"
    end
  end

  describe "changeset/2: cellphone" do
    test "is empty" do
      changeset = User.changeset(%User{}, %{@attrs | cellphone: ""})

      assert get_error_message(changeset, :cellphone) == "can't be blank"
    end
  end

  describe "changeset/2: email" do
    test "is empty" do
      changeset = User.changeset(%User{}, %{@attrs | email: ""})

      assert get_error_message(changeset, :email) == "can't be blank"
    end

    test "is not valid" do
      changeset = User.changeset(%User{}, %{@attrs | email: "test@gmailcom"})

      assert get_error_message(changeset, :email) == "has invalid format"
    end

    test "is not unique" do
      insert(:user, email: "test@gmail.com")

      {:error, changeset} =
        %User{}
        |> User.changeset(%{@attrs | email: "test@gmail.com"})
        |> Repo.insert()

      assert get_error_message(changeset, :email) == "has already been taken"
    end
  end

  describe "changeset/2: password" do
    test "is empty" do
      changeset = User.changeset(%User{}, %{@attrs | password: ""})

      assert get_error_message(changeset, :password) == "can't be blank"
    end
  end

  describe "changeset/2: password_confirmation" do
    test "not match password" do
      changeset =
        User.changeset(%User{}, %{
          @attrs
          | password: "abc12345",
            password_confirmation: "abc123456"
        })

      assert get_error_message(changeset, :password_confirmation) == "does not match confirmation"
    end
  end
end
