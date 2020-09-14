defmodule AmarisPhoenixLabWeb.MaterialLive.FormComponent do
  use AmarisPhoenixLabWeb, :live_component

  alias AmarisPhoenixLab.CMS

  @impl true
  def update(%{material: material} = assigns, socket) do
    IO.puts("Updating material")
    changeset = CMS.change_material(material)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"material" => material_params}, socket) do
    project_id = socket.assigns.project_id
    material_params = Map.put(material_params, "project_id", project_id)

    IO.puts("Validating material:")

    changeset =
      socket.assigns.material
      |> CMS.change_material(material_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"material" => material_params}, socket) do
    save_material(socket, socket.assigns.action, material_params)
  end

  defp save_material(socket, :upload, material_params) do
    project_id = socket.assigns.project_id
    material_params = Map.put(material_params, "project_id", project_id)

    case CMS.create_material(material_params) do
      {:ok, _material} ->
        {:noreply,
         socket
         |> put_flash(:info, "Material uploaded successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
