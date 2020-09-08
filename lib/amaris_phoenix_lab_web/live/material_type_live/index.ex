defmodule AmarisPhoenixLabWeb.MaterialTypeLive.Index do
  use AmarisPhoenixLabWeb, :live_view

  alias AmarisPhoenixLab.CMS
  alias AmarisPhoenixLab.CMS.MaterialType

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :material_types, list_material_types())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Material type")
    |> assign(:material_type, CMS.get_material_type!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Material type")
    |> assign(:material_type, %MaterialType{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Material types")
    |> assign(:material_type, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    material_type = CMS.get_material_type!(id)
    {:ok, _} = CMS.delete_material_type(material_type)

    {:noreply, assign(socket, :material_types, list_material_types())}
  end

  defp list_material_types do
    CMS.list_material_types()
  end
end
