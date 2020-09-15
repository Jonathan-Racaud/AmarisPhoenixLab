defmodule AmarisPhoenixLabWeb.UserLive.Show do
  use AmarisPhoenixLabWeb, :live_view

  alias Ecto.Multi
  alias AmarisPhoenixLab.Users
  alias AmarisPhoenixLabWeb.Credentials

  @impl true
  def mount(_params, session, socket) do
    current_user = Credentials.get_user(socket, session)
    {:ok, assign(socket, current_user: current_user)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user, Users.get_user!(id))}
  end

  defp page_title(:show), do: "Show User"
  defp page_title(:edit), do: "Edit User"
end
