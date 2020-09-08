defmodule AmarisPhoenixLab.Repo.Migrations.AddTableProjectCategory do
  use Ecto.Migration

  def change do
    create table(:project_categories, primary_key: false) do
      add(:project_id, references(:projects, on_delete: delete_all), primary_key: true)
      add(:category_id, references(:categories, on_delete: delete_all), primary_key: true)

      timestamps()
    end

    create index(:project_categories, [:project_id])
    create index(:project_categories, [:category_id])

    create unique_index(:project_categories, [:project_id, :category_id], name: :project_id_category_id_unique_index)
  end
end
