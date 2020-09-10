defmodule AmarisPhoenixLabWeb.UserLive.Index do
  use AmarisPhoenixLabWeb, :live_view
  alias AmarisPhoenixLabWeb.Credentials
  alias AmarisPhoenixLab.{Users, Users.User}

  @impl true
  def mount(_params, session, socket) do
    current_user = Credentials.get_user(socket, session)
    {:ok, assign(socket, users: list_users(), current_user: current_user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => _id} = clause) do
    socket
    |> assign(:page_title, "Edit User")
    |> assign(:project, Users.get_by(clause))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:user, %User{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:users, list_users())
  end

  @impl true
  def handle_event("delete", %{"id" => _id} = clause, socket) do
    user = Users.get_by(clause)
    {:ok, _} = Users.delete(user)

    {:noreply, assign(socket, :users, list_users())}
  end

  defp list_users do
    Users.list_users()
  end
end
