defmodule AmarisPhoenixLab.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias AmarisPhoenixLab.Repo
  alias AmarisPhoenixLab.Users.User

  @type t :: %User{}

  @spec create_admin(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_admin(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "admin"})
    |> Repo.insert()
  end

  @spec create_admin(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_user(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "user"})
    |> Repo.insert()
  end

  @spec set_admin_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_admin_role(user) do
    user
    |> User.changeset_role(%{role: "admin"})
    |> Repo.update()
  end
end
