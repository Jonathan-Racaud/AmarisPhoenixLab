defmodule AmarisPhoenixLab.CMS.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias AmarisPhoenixLab.CMS.{ProjectCategory, Project}

  schema "categories" do
    field :name, :string

    many_to_many :projects, Project, join_through: ProjectCategory, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
