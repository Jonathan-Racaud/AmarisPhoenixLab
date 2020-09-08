defmodule AmarisPhoenixLab.CMS.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias AmarisPhoenixLab.Accounts.User
  alias AmarisPhoenixLab.CMS.UserProject

  schema "projects" do
    field :description, :string
    field :is_deleted, :string
    field :name, :string
    field :owner_id, :id

    many_to_many :user_projects, User, join_through: UserProject, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description, :is_deleted])
    |> validate_required([:name, :description, :is_deleted])
  end
end
