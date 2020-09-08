defmodule AmarisPhoenixLab.CMS.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :description, :string
    field :is_deleted, :string
    field :name, :string
    field :owner_id, :id

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description, :is_deleted])
    |> validate_required([:name, :description, :is_deleted])
  end
end
