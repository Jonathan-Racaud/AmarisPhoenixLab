defmodule AmarisPhoenixLab.CMS.Material do
  use Ecto.Schema
  import Ecto.Changeset

  schema "materials" do
    field :name, :string
    field :source, :string
    field :project_id, :id
    field :type_id, :id

    timestamps()
  end

  @doc false
  def changeset(material, attrs) do
    material
    |> cast(attrs, [:name, :source])
    |> validate_required([:name, :source])
  end
end
