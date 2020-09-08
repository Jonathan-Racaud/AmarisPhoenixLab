defmodule AmarisPhoenixLabWeb.MaterialTypeLive.Show do
  use AmarisPhoenixLabWeb, :live_view

  alias AmarisPhoenixLab.CMS

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:material_type, CMS.get_material_type!(id))}
  end

  defp page_title(:show), do: "Show Material type"
  defp page_title(:edit), do: "Edit Material type"
end
