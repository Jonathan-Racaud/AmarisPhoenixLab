defmodule AmarisPhoenixLabWeb.UserLive.Show do
  use AmarisPhoenixLabWeb, :live_view

  alias AmarisPhoenixLab.Users

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => _id} = clause, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user, Users.get_by(clause))}
  end

  defp page_title(:show), do: "Show User"
  defp page_title(:edit), do: "Edit User"
end
