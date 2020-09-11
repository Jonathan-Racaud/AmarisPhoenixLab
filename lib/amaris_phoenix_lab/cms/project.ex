defmodule AmarisPhoenixLab.CMS.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias AmarisPhoenixLab.Users.User
  alias AmarisPhoenixLab.CMS.Category
  # alias AmarisPhoenixLab.CMS.{UserProject, ProjectCategory, Category}

  schema "projects" do
    field :description, :string
    field :is_deleted, :string
    field :name, :string
    field :owner_id, :id

    # join_through must be the string name of the schema otherwise association cannot be added.
    # It cannot be UserProject for example.
    many_to_many :contributors, User, join_through: "user_projects", on_replace: :delete
    many_to_many :categories, Category, join_through: "project_categories", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description, :owner_id])
    |> validate_required([:name, :description, :owner_id])
  end
end
