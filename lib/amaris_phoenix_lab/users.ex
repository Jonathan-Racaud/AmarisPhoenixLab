defmodule AmarisPhoenixLab.Users do
  @moduledoc """
  The Users context.
  """
  use Pow.Ecto.Context,
    repo: AmarisPhoenixLab.Repo,
    user: AmarisPhoenixLab.Users.User
  alias AmarisPhoenixLab.{Repo, Users.User}

  @type t :: %User{}

  @spec create_admin(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_admin(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "admin"})
    |> Repo.insert()
  end

  @spec create_user(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_user(params) do
    # %User{}
    # |> User.changeset(params)
    # |> User.changeset_role(%{role: "user"})
    # |> Repo.insert()
    pow_create(params)
  end

  @spec set_admin_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_admin_role(user) do
    user
    |> User.changeset_role(%{role: "admin"})
    |> Repo.update()
  end

  @spec is_admin?(t()) :: boolean()
  def is_admin?(%{role: "admin"}), do: true
  def is_admin?(_any), do: false

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def update_user(attrs) do
    pow_create(attrs)
  end

  def list_users do
    Repo.all(User)
  end

  def get_with_projects(clauses) do
    get_by(clauses)
    |> Repo.preload(:user_projects)
  end
end
