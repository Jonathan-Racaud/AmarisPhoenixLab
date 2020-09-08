defmodule AmarisPhoenixLab.Authorization do
  alias __MODULE__
  alias AmarisPhoenixLab.Users.User
  alias AmarisPhoenixLab.CMS.Project
  defstruct role: nil, create: %{}, read: %{}, update: %{}, delete: %{}

  def can("Regular" = role) do
    grant(role)
    |> read(Project)
    |> read(User)
    |> update(Project)
    |> update(User)
  end

  def can("Admin" = role) do
    grant(role)
    |> all(Project)
    |> all(User)
  end

  def grant(role), do: %Authorization{role: role}

  def read(authorization, resource), do: put_action(authorization, resource, :read)
  def read?(authorization, resource), do: has_action(authorization, resource, :read)

  def create(authorization, resource), do: put_action(authorization, resource, :create)
  def create?(authorization, resource), do: has_action(authorization, resource, :create)

  def update(authorization, resource), do: put_action(authorization, resource, :update)
  def update?(authorization, resource), do: has_action(authorization, resource, :update)

  def delete(authorization, resource), do: put_action(authorization, resource, :delete)
  def delete?(authorization, resource), do: has_action(authorization, resource, :delete)

  def all(authorization, resource) do
    authorization
    |> create(resource)
    |> read(resource)
    |> update(resource)
    |> delete(resource)
  end

  defp put_action(authorization, resource, action) do
    updated_action =
      authorization
      |> Map.get(action)
      |> Map.put(resource, true)

    Map.put(authorization, action, updated_action)
  end

  defp has_action(authorization, resource, action) do
    authorization
    |> Map.get(action)
    |> Map.get(resource, false)
  end
end
