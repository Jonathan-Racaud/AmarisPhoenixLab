defmodule AmarisPhoenixLab.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string
      add :role_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
