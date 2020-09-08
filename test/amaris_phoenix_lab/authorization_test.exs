defmodule AmarisPhoenixLab.AuthorizationTest do
  use ExUnit.Case
  import AmarisPhoenixLab.Authorization, except: [can: 1]
  alias AmarisPhoenixLab.CMS.Project

  def can("kiosk" = role) do
    grant(role)
    |> read(Project)
  end

  test "regular can read resource" do
    assert can("regular") |> read?(Project)
  end

  test "regular cannot create resource" do
    can_create = can("regular") |> create?(Project) == false
    assert can_create
  end

  test "regular cannot update resource" do
    can_update = can("regular") |> update?(Project) == false
    assert can_update
  end

  test "regular cannot delete resource" do
    can_delete = can("regular") |> delete?(Project) == false
    assert can_delete
  end
end
