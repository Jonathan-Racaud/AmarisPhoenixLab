defmodule AmarisPhoenixLab.Repo.Migrations.CreateMaterials do
  use Ecto.Migration

  def change do
    create table(:materials) do
      add :name, :string
      add :source, :string, unique: true
      add :content_type, :string
      add :project_id, references(:projects, on_delete: :nothing)
      add :type_id, references(:material_types, on_delete: :nothing)

      timestamps()
    end

    create index(:materials, [:project_id])
    create index(:materials, [:type_id])
  end
end
