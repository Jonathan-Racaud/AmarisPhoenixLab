defmodule AmarisPhoenixLab.CMS do
  @moduledoc """
  The CMS context.
  """

  import Ecto.Query, warn: false
  alias AmarisPhoenixLab.Repo

  alias AmarisPhoenixLab.CMS.Project
  alias AmarisPhoenixLab.{Users}

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Project
    |> Repo.all
    |> Repo.preload(:contributors)
    |> Repo.preload(:categories)
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
  def get_project!(id) do
    Repo.get!(Project, id)
    |> Repo.preload(:contributors)
    |> Repo.preload(:categories)
  end

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{contributors: [], categories: []}
    |> Project.changeset(attrs)
    |> maybe_put_categories(attrs)
    |> maybe_put_contributors(attrs)
    |> Repo.insert()
    |> notify_subscribers([:projects, :created])
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
    |> Repo.preload(:contributors)
    |> Project.changeset(attrs)
    |> maybe_put_contributors(attrs)
    |> maybe_put_categories(attrs)
    |> Repo.update()
    |> notify_subscribers([:projects, :updated])
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
    |> notify_subscribers([:projects, :deleted])
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

  defp maybe_put_contributors(project_or_changeset, %{"contributors_id" => _contributors_id } = params) do
    IO.puts("Maybe_put_contributors 2")
    ids = Enum.map(params["contributors_id"], &String.to_integer/1)
    contributors = Users.get_users(ids)

    project_or_changeset
    |> Ecto.Changeset.put_assoc(:contributors, contributors)
  end
  defp maybe_put_contributors(project_or_changeset, _), do: project_or_changeset

  defp maybe_put_categories(project_or_changeset, %{"categories_id" => categories_id}) do
    ids = Enum.map(categories_id, &String.to_integer/1)
    categories = get_categories(ids)

    project_or_changeset
    |> Ecto.Changeset.put_assoc(:categories, categories)
  end
  defp maybe_put_categories(project_or_changeset, _), do: project_or_changeset

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

  def get_categories(nil), do: []
  def get_categories(ids) do
    Category
    |> where([c], c.id in ^ids)
    |> Repo.all
  end

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

  alias AmarisPhoenixLab.CMS.Material

  @upload_dir "priv/materials"
  @material_error {:error, "Couldn't save file or url."}

  @doc """
  Returns the list of materials.

  ## Examples

      iex> list_materials()
      [%Material{}, ...]

  """
  def list_materials do
    Repo.all(Material)
  end

  @doc """
  Gets a single material.

  Raises `Ecto.NoResultsError` if the Material does not exist.

  ## Examples

      iex> get_material!(123)
      %Material{}

      iex> get_material!(456)
      ** (Ecto.NoResultsError)

  """
  def get_material!(id), do: Repo.get!(Material, id)

  def get_materials(project_id) do
    Material
    |> where([m], m.project_id == ^project_id)
    |> Repo.all()
  end

  @doc """
  Creates a material.

  ## Examples

      iex> create_material(%{field: value})
      {:ok, %Material{}}

      iex> create_material(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @url_type 4

  def create_material(attrs \\ %{}) do
    case get_file_or_url(attrs) do
      {:error, _} -> @material_error

      {:ok, :url, url} ->
        attrs = Map.put(attrs, "source", url)
        save_material_to_db(attrs)

      {:ok, :file, file} ->
        try do
          project_id = attrs["project_id"]
          material_folder = Path.absname("#{@upload_dir}/#{project_id}")
          file_path = Path.absname("#{material_folder}/#{file}")

          File.mkdir_p!(material_folder)
          file_base_64 = attrs["file_base_64"]

          IO.puts "file_base_64:"
          IO.inspect(file_base_64)

          {_data_start, data_length} = :binary.match(file_base_64, "data:")
          {raw_start, raw_length} = :binary.match(file_base_64, ";base64,")
          content_type = :binary.part(file_base_64, data_length, raw_start - data_length)
          raw = :binary.part(file_base_64, raw_start + raw_length, byte_size(file_base_64) - raw_start - raw_length)

          File.write!(file_path, Base.decode64!(raw))
          attrs = Map.put(attrs, "source", file_path)
          attrs = Map.put(attrs, "content_type", content_type)
          save_material_to_db(attrs)
        rescue
          File.Error -> @material_error
        end
    end
  end

  defp save_material_to_db(attrs) do
    IO.puts("Saving material to db")
    %Material{}
    |> Material.changeset(attrs)
    |> Repo.insert()
  end

  defp get_file_or_url([]), do: @material_error
  defp get_file_or_url(attrs) do
    case attrs["type_id"] do
      @url_type -> {:ok, :url, attrs["url"]}
      _ -> {:ok, :file, attrs["file_name"]}
    end
  end

  @doc """
  Updates a material.

  ## Examples

      iex> update_material(material, %{field: new_value})
      {:ok, %Material{}}

      iex> update_material(material, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_material(%Material{} = material, attrs) do
    material
    |> Material.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a material.

  ## Examples

      iex> delete_material(material)
      {:ok, %Material{}}

      iex> delete_material(material)
      {:error, %Ecto.Changeset{}}

  """
  def delete_material(%Material{} = material) do
    Repo.delete(material)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking material changes.

  ## Examples

      iex> change_material(material)
      %Ecto.Changeset{data: %Material{}}

  """
  def change_material(%Material{} = material, attrs \\ %{}) do
    Material.changeset(material, attrs)
  end

  def subscribe(:projects) do
    Phoenix.PubSub.subscribe(AmarisPhoenixLab.PubSub, "projects")
  end

  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(AmarisPhoenixLab.PubSub, "projects", {"projects", event, result})

    {:ok, result}
  end
end
