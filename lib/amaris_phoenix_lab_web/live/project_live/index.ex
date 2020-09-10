defmodule AmarisPhoenixLabWeb.ProjectLive.Index do
  use AmarisPhoenixLabWeb, :live_view
  alias AmarisPhoenixLab.CMS
  alias AmarisPhoenixLab.CMS.Project
  alias AmarisPhoenixLabWeb.Credentials
  alias AmarisPhoenixLab.Users

  @impl true
  def mount(_params, session, socket) do
    current_user = Credentials.get_user(socket, session)

    {:ok, assign(socket, projects: list_projects(), current_user: current_user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Project")
    |> assign(:project, CMS.get_project!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Project")
    |> assign(:project, get_new_project())
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Projects")
    |> assign(:project, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    project = CMS.get_project!(id)
    {:ok, _} = CMS.delete_project(project)

    {:noreply, assign(socket, :projects, list_projects())}
  end

  defp list_projects do
    CMS.list_projects()
  end

  defp list_categories do
    CMS.list_categories()
  end

  defp list_users do
    Users.list_users()
  end

  def get_new_project do
    %Project{}
    |> Map.put(:contributors, [])
    |> Map.put(:categories, [])
  end
end
