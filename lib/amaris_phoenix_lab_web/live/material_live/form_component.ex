defmodule AmarisPhoenixLabWeb.MaterialLive.FormComponent do
  use AmarisPhoenixLabWeb, :live_component

  alias AmarisPhoenixLab.CMS

  @impl true
  def update(%{material: material} = assigns, socket) do
    changeset = CMS.change_material(material)
    type = changeset.data.type_id

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:type, type)}
  end

  @impl true
  def handle_event("validate", %{"material" => material_params}, socket) do
    project_id = socket.assigns.project_id
    type_id = String.to_integer(Map.get(material_params, "type_id"))
    file_content = Map.get(material_params, "file_base_64")

    IO.inspect(file_content)

    material_params =
      material_params
      |> Map.put("project_id", project_id)
      |> Map.put("file_base_64", file_content)

    changeset =
      socket.assigns.material
      |> CMS.change_material(material_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset, type: type_id)}
  end

  def handle_event("save", %{"material" => material_params}, socket) do
    IO.puts("Saving material")
    save_material(socket, socket.assigns.action, material_params)
  end

  defp save_material(socket, :upload, material_params) do
    project_id = socket.assigns.project_id
    material_params = Map.put(material_params, "type_id", socket.assigns.type)
    material_params = Map.put(material_params, "project_id", project_id)

    case CMS.create_material(material_params) do
      {:ok, _material} ->
        {:noreply,
         socket
         |> put_flash(:info, "Material uploaded successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, _} ->
        changeset = %Ecto.Changeset{}
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
