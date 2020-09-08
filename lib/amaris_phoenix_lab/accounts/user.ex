defmodule AmarisPhoenixLab.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias AmarisPhoenixLab.CMS.Project
  alias AmarisPhoenixLab.CMS.UserProject

  schema "users" do
    field :email, :string
    field :is_deleted, :boolean, default: false
    field :name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string

    many_to_many :user_projects, Project, join_through: UserProject, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :password_confirmation])
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:email)
  end
end
