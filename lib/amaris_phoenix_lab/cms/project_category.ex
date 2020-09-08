defmodule AmarisPhoenixLab.CMS.ProjectCategory do
  use Ecto.Schema
  alias AmarisPhoenixLab.CMS.{Category, Project}

  @primary_key false
  schema "user_projects" do
    belongs_to :projects, Project
    belongs_to :categories, Category

    timestamps()
  end
end
