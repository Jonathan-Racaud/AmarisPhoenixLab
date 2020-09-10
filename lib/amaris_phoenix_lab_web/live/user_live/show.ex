defmodule AmarisPhoenixLabWeb.UserLive.Show do
  use AmarisPhoenixLabWeb, :live_view

  alias AmarisPhoenixLab.Users
  alias AmarisPhoenixLabWeb.Credentials

  @impl true
  def mount(_params, session, socket) do
    current_user = Credentials.get_user(socket, session)
    {:ok, assign(socket, current_user: current_user)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    Users.get_with_projects([id: id])
    |> IO.inspect

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user, Users.get_with_projects([id: id]))}
  end

  defp page_title(:show), do: "Show User"
  defp page_title(:edit), do: "Edit User"
end
