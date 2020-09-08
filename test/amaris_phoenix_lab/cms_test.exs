defmodule AmarisPhoenixLab.CMSTest do
  use AmarisPhoenixLab.DataCase

  alias AmarisPhoenixLab.CMS

  describe "projects" do
    alias AmarisPhoenixLab.CMS.Project

    @valid_attrs %{description: "some description", is_deleted: "some is_deleted", name: "some name"}
    @update_attrs %{description: "some updated description", is_deleted: "some updated is_deleted", name: "some updated name"}
    @invalid_attrs %{description: nil, is_deleted: nil, name: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert CMS.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert CMS.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = CMS.create_project(@valid_attrs)
      assert project.description == "some description"
      assert project.is_deleted == "some is_deleted"
      assert project.name == "some name"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = CMS.update_project(project, @update_attrs)
      assert project.description == "some updated description"
      assert project.is_deleted == "some updated is_deleted"
      assert project.name == "some updated name"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_project(project, @invalid_attrs)
      assert project == CMS.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = CMS.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = CMS.change_project(project)
    end
  end
end
