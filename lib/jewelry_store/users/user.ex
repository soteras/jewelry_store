defmodule JewelryStore.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias JewelryStore.Shared.Regex
  alias JewelryStore.Types.{DowncaseString, TrimmedString}

  @required_fields [:name, :cpf, :gender, :cellphone, :email, :password, :password_confirmation]
  @optional_fields [:rg, :nickname, :birthdate]

  @genders ["female", "male", "other"]

  schema "users" do
    field :birthdate, :date
    field :cellphone, TrimmedString
    field :cpf, TrimmedString
    field :email, DowncaseString
    field :gender, DowncaseString, default: "female"
    field :name, TrimmedString
    field :nickname, TrimmedString
    field :rg, TrimmedString
    field :password_hash, TrimmedString
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :admin, :boolean, default: false

    timestamps()
  end

  def changeset(%__MODULE__{} = struct, attrs) do
    struct
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:gender, @genders)
    |> validate_format(:email, Regex.email_regex())
    |> unique_constraint(:email)
    |> Brcpfcnpj.Changeset.validate_cpf(:cpf)
    |> format_cpf
    |> validate_length(:cpf, is: 14)
    |> unique_constraint(:cpf)
    |> validate_confirmation(:password)
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{changes: %{password: password}, valid?: true} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end

  defp format_cpf(%Ecto.Changeset{changes: %{cpf: cpf}} = changeset) do
    cpf_formatted = Brcpfcnpj.cpf_format(%Cpf{number: cpf})
    put_change(changeset, :cpf, cpf_formatted)
  end

  defp format_cpf(changeset), do: changeset
end
