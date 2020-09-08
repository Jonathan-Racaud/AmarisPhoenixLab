defmodule AmarisPhoenixLab.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :is_deleted, :boolean, default: false
    field :name, :string
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash, :is_deleted])
    |> validate_required([:name, :email, :password_hash, :is_deleted])
    |> unique_constraint(:email)
  end
end
