defmodule AmarisPhoenixLab.CMS.UserProject do
  use Ecto.Schema
  alias AmarisPhoenixLab.Users.User
  alias AmarisPhoenixLab.CMS.Project

  @primary_key false
  schema "user_projects" do
    belongs_to :users, User, primary_key: true
    belongs_to :projects, Project, primary_key: true
  end
end
