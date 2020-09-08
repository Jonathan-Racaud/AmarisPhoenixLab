defmodule AmarisPhoenixLabWeb.MaterialLive.FormComponent do
  use AmarisPhoenixLabWeb, :live_component

  alias AmarisPhoenixLab.CMS

  @impl true
  def update(%{material: material} = assigns, socket) do
    changeset = CMS.change_material(material)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"material" => material_params}, socket) do
    changeset =
      socket.assigns.material
      |> CMS.change_material(material_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"material" => material_params}, socket) do
    save_material(socket, socket.assigns.action, material_params)
  end

  defp save_material(socket, :edit, material_params) do
    case CMS.update_material(socket.assigns.material, material_params) do
      {:ok, _material} ->
        {:noreply,
         socket
         |> put_flash(:info, "Material updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_material(socket, :new, material_params) do
    case CMS.create_material(material_params) do
      {:ok, _material} ->
        {:noreply,
         socket
         |> put_flash(:info, "Material created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
