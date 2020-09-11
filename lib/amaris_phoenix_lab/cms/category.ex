defmodule AmarisPhoenixLab.CMS.Category do
  use Ecto.Schema
  import Ecto.Changeset
  # alias AmarisPhoenixLab.CMS.Project

  schema "categories" do
    field :name, :string

    # many_to_many :projects, Project, join_through: "project_categories", on_replace: :delete
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
