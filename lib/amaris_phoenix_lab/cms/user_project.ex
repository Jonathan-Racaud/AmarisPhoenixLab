defmodule AmarisPhoenixLab.CMS.UserProject do
  use Ecto.Schema
  alias AmarisPhoenixLab.Accounts.User
  alias AmarisPhoenixLab.CMS.Project

  @primary_key false
  schema "user_projects" do
    belongs_to :users, User
    belongs_to :projects, Project

    timestamps()
  end
end
