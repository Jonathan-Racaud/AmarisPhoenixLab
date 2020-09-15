defmodule AmarisPhoenixLab.Users do
  @moduledoc """
  The Users context.
  """
  use Pow.Ecto.Context,
    repo: AmarisPhoenixLab.Repo,
    user: AmarisPhoenixLab.Users.User
  import Ecto.Query
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
    pow_create(params)
  end

  @spec set_admin_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_admin_role(user) do
    user
    |> User.changeset_role(%{role: "admin"})
    |> Repo.preload(:projects)
    |> Repo.update()
  end

  @spec is_admin?(t()) :: boolean()
  def is_admin?(%{role: "admin"}), do: true
  def is_admin?(_any), do: false

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def update_user(user, attrs) do
    pow_update(user, attrs)
  end

  def list_users do
    User
    |> select([:id, :email, :role])
    |> Repo.all
    |> Repo.preload(:projects)
  end

  def get_user!(id) do
     pow_get_by([id: id])
     |> Repo.preload(:projects)
  end

  def get_users(nil), do: []
  def get_users(ids) do
    User
    |> where([u], u.id in ^ids)
    |> Repo.all
    |> Repo.preload(:projects)
  end

  def can_edit_user(current_user, user) do
    if is_admin?(current_user) do
      true
    else
      current_user.id == user.id
    end
  end
end
