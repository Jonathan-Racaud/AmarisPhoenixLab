defmodule AmarisPhoenixLabWeb.MaterialLive.Index do
  use AmarisPhoenixLabWeb, :live_view

  alias AmarisPhoenixLab.CMS
  alias AmarisPhoenixLab.CMS.Material

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :materials, list_materials())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Material")
    |> assign(:material, CMS.get_material!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Material")
    |> assign(:material, %Material{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Materials")
    |> assign(:material, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    material = CMS.get_material!(id)
    {:ok, _} = CMS.delete_material(material)

    {:noreply, assign(socket, :materials, list_materials())}
  end

  defp list_materials do
    CMS.list_materials()
  end
end
