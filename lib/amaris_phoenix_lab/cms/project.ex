defmodule AmarisPhoenixLab.CMS.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias AmarisPhoenixLab.Users.User
  alias AmarisPhoenixLab.CMS.{UserProject, ProjectCategory, Category}

  schema "projects" do
    field :description, :string
    field :is_deleted, :string
    field :name, :string
    field :owner_id, :id

    many_to_many :contributors, User, join_through: UserProject, on_replace: :delete
    many_to_many :categories, Category, join_through: ProjectCategory, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description, :owner_id])
    |> validate_required([:name, :description, :owner_id])
  end
end
