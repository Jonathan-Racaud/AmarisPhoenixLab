defmodule AmarisPhoenixLab.CMS.MaterialType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "material_types" do
    field :name, :string
  end

  @doc false
  def changeset(material_type, attrs) do
    material_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
