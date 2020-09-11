defmodule AmarisPhoenixLab.Repo.Migrations.AddTableUserProject do
  use Ecto.Migration

  def change do
    create table(:user_projects, primary_key: false) do
      add(:project_id, references(:projects, on_delete: :delete_all), primary_key: true)
      add(:user_id, references(:users, on_delete: :delete_all), primary_key: true)
    end

    create index(:user_projects, [:project_id])
    create index(:user_projects, [:user_id])

    create unique_index(:user_projects, [:project_id, :user_id], name: :user_id_project_id_unique_index)
  end
end
