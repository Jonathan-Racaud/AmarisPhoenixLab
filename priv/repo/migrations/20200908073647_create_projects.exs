defmodule AmarisPhoenixLab.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :description, :string
      add :is_deleted, :string
      add :owner_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:projects, [:owner_id])
  end
end
