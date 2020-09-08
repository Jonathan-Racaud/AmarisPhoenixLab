defmodule AmarisPhoenixLab.AuthorizationTest do
  use ExUnit.Case
  import AmarisPhoenixLab.Authorization, except: [can: 1]
  alias AmarisPhoenixLab.CMS.Project

  def can("regular" = role) do
    grant(role)
    |> read(Project)
  end

  test "regular can read resource" do
    assert can("regular") |> read?(Project)
  end

  test "regular cannot create resource" do
    refute can("regular") |> create?(Project)
  end

  test "regular cannot update resource" do
    refute can("regular") |> update?(Project)
  end

  test "regular cannot delete resource" do
    refute can("regular") |> delete?(Project)
  end
end
