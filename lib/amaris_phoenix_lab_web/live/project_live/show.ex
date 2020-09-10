defmodule AmarisPhoenixLabWeb.ProjectLive.Show do
  use AmarisPhoenixLabWeb, :live_view

  alias AmarisPhoenixLab.CMS
  alias AmarisPhoenixLab.Users
  alias AmarisPhoenixLabWeb.Credentials

  @impl true
  def mount(_params, session, socket) do
    current_user = Credentials.get_user(socket, session)
    {:ok, assign(socket, current_user: current_user)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    CMS.get_project!(id)
    |> IO.inspect()

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:project, CMS.get_project!(id))}
  end

  defp page_title(:show), do: "Show Project"
  defp page_title(:edit), do: "Edit Project"
end
