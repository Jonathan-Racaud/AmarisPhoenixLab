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

  describe "categories" do
    alias AmarisPhoenixLab.CMS.Category

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert CMS.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert CMS.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = CMS.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = CMS.update_category(category, @update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_category(category, @invalid_attrs)
      assert category == CMS.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = CMS.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = CMS.change_category(category)
    end
  end

  describe "material_types" do
    alias AmarisPhoenixLab.CMS.MaterialType

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def material_type_fixture(attrs \\ %{}) do
      {:ok, material_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_material_type()

      material_type
    end

    test "list_material_types/0 returns all material_types" do
      material_type = material_type_fixture()
      assert CMS.list_material_types() == [material_type]
    end

    test "get_material_type!/1 returns the material_type with given id" do
      material_type = material_type_fixture()
      assert CMS.get_material_type!(material_type.id) == material_type
    end

    test "create_material_type/1 with valid data creates a material_type" do
      assert {:ok, %MaterialType{} = material_type} = CMS.create_material_type(@valid_attrs)
      assert material_type.name == "some name"
    end

    test "create_material_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_material_type(@invalid_attrs)
    end

    test "update_material_type/2 with valid data updates the material_type" do
      material_type = material_type_fixture()
      assert {:ok, %MaterialType{} = material_type} = CMS.update_material_type(material_type, @update_attrs)
      assert material_type.name == "some updated name"
    end

    test "update_material_type/2 with invalid data returns error changeset" do
      material_type = material_type_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_material_type(material_type, @invalid_attrs)
      assert material_type == CMS.get_material_type!(material_type.id)
    end

    test "delete_material_type/1 deletes the material_type" do
      material_type = material_type_fixture()
      assert {:ok, %MaterialType{}} = CMS.delete_material_type(material_type)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_material_type!(material_type.id) end
    end

    test "change_material_type/1 returns a material_type changeset" do
      material_type = material_type_fixture()
      assert %Ecto.Changeset{} = CMS.change_material_type(material_type)
    end
  end

  describe "materials" do
    alias AmarisPhoenixLab.CMS.Material

    @valid_attrs %{name: "some name", source: "some source"}
    @update_attrs %{name: "some updated name", source: "some updated source"}
    @invalid_attrs %{name: nil, source: nil}

    def material_fixture(attrs \\ %{}) do
      {:ok, material} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_material()

      material
    end

    test "list_materials/0 returns all materials" do
      material = material_fixture()
      assert CMS.list_materials() == [material]
    end

    test "get_material!/1 returns the material with given id" do
      material = material_fixture()
      assert CMS.get_material!(material.id) == material
    end

    test "create_material/1 with valid data creates a material" do
      assert {:ok, %Material{} = material} = CMS.create_material(@valid_attrs)
      assert material.name == "some name"
      assert material.source == "some source"
    end

    test "create_material/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_material(@invalid_attrs)
    end

    test "update_material/2 with valid data updates the material" do
      material = material_fixture()
      assert {:ok, %Material{} = material} = CMS.update_material(material, @update_attrs)
      assert material.name == "some updated name"
      assert material.source == "some updated source"
    end

    test "update_material/2 with invalid data returns error changeset" do
      material = material_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_material(material, @invalid_attrs)
      assert material == CMS.get_material!(material.id)
    end

    test "delete_material/1 deletes the material" do
      material = material_fixture()
      assert {:ok, %Material{}} = CMS.delete_material(material)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_material!(material.id) end
    end

    test "change_material/1 returns a material changeset" do
      material = material_fixture()
      assert %Ecto.Changeset{} = CMS.change_material(material)
    end
  end
end
