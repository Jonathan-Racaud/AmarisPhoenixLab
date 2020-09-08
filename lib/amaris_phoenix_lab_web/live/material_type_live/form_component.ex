defmodule AmarisPhoenixLabWeb.MaterialTypeLive.FormComponent do
  use AmarisPhoenixLabWeb, :live_component

  alias AmarisPhoenixLab.CMS

  @impl true
  def update(%{material_type: material_type} = assigns, socket) do
    changeset = CMS.change_material_type(material_type)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"material_type" => material_type_params}, socket) do
    changeset =
      socket.assigns.material_type
      |> CMS.change_material_type(material_type_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"material_type" => material_type_params}, socket) do
    save_material_type(socket, socket.assigns.action, material_type_params)
  end

  defp save_material_type(socket, :edit, material_type_params) do
    case CMS.update_material_type(socket.assigns.material_type, material_type_params) do
      {:ok, _material_type} ->
        {:noreply,
         socket
         |> put_flash(:info, "Material type updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_material_type(socket, :new, material_type_params) do
    case CMS.create_material_type(material_type_params) do
      {:ok, _material_type} ->
        {:noreply,
         socket
         |> put_flash(:info, "Material type created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
