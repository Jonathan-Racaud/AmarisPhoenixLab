defmodule AmarisPhoenixLab.CMS.Material do
  use Ecto.Schema
  import Ecto.Changeset

  schema "materials" do
    field :name, :string
    field :source, :string, unique: true
    field :content_type, :string
    field :project_id, :id
    field :type_id, :id

    timestamps()
  end

  @doc false
  def changeset(material, attrs) do
    material
    |> cast(attrs, [:name, :project_id, :type_id, :source, :content_type])
    |> validate_required([:name, :project_id, :type_id, :source])
  end
end
