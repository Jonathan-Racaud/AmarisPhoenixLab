defmodule AmarisPhoenixLab.CMS do
  @moduledoc """
  The CMS context.
  """

  import Ecto.Query, warn: false
  alias AmarisPhoenixLab.Repo

  alias AmarisPhoenixLab.CMS.Project

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!(123)
      %Project{}

      iex> get_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project!(id), do: Repo.get!(Project, id)

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{data: %Project{}}

  """
  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end

  alias AmarisPhoenixLab.CMS.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  alias AmarisPhoenixLab.CMS.MaterialType

  @doc """
  Returns the list of material_types.

  ## Examples

      iex> list_material_types()
      [%MaterialType{}, ...]

  """
  def list_material_types do
    Repo.all(MaterialType)
  end

  @doc """
  Gets a single material_type.

  Raises `Ecto.NoResultsError` if the Material type does not exist.

  ## Examples

      iex> get_material_type!(123)
      %MaterialType{}

      iex> get_material_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_material_type!(id), do: Repo.get!(MaterialType, id)

  @doc """
  Creates a material_type.

  ## Examples

      iex> create_material_type(%{field: value})
      {:ok, %MaterialType{}}

      iex> create_material_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_material_type(attrs \\ %{}) do
    %MaterialType{}
    |> MaterialType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a material_type.

  ## Examples

      iex> update_material_type(material_type, %{field: new_value})
      {:ok, %MaterialType{}}

      iex> update_material_type(material_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_material_type(%MaterialType{} = material_type, attrs) do
    material_type
    |> MaterialType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a material_type.

  ## Examples

      iex> delete_material_type(material_type)
      {:ok, %MaterialType{}}

      iex> delete_material_type(material_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_material_type(%MaterialType{} = material_type) do
    Repo.delete(material_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking material_type changes.

  ## Examples

      iex> change_material_type(material_type)
      %Ecto.Changeset{data: %MaterialType{}}

  """
  def change_material_type(%MaterialType{} = material_type, attrs \\ %{}) do
    MaterialType.changeset(material_type, attrs)
  end
end
