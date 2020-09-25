defmodule AmarisPhoenixLabWeb.ProjectLive.Show do
  use AmarisPhoenixLabWeb, :live_view

  alias AmarisPhoenixLab.{CMS, CMS.Project, CMS.Material}
  alias AmarisPhoenixLab.{Users, Users.User}
  alias AmarisPhoenixLabWeb.Credentials

  @impl true
  def mount(_params, session, socket) do
    current_user = Credentials.get_user(socket, session)

    if connected?(socket), do: CMS.subscribe(:projects)

    {:ok, assign(socket, current_user: current_user)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    project = CMS.get_project!(id)
    materials = CMS.get_materials(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:project, project)
     |> assign(:materials, materials)}
  end

  @impl true
  def handle_event("leave_project", %{"user" => user_id, "value" => _}, socket) do
    project = socket.assigns.project
    user = Users.get_user!(String.to_integer(user_id))

    contributors_id = project
    |> Map.get(:contributors)
    |> Enum.reject(fn(u) -> u.id == user.id end)
    |> Enum.map(fn u -> u.id end)

    update_project(socket, project, %{"contributors_id" => contributors_id})
  end

  @impl true
  def handle_event("join_project", %{"user" => user_id, "value" => _}, socket) do
    project = socket.assigns.project
    user = Users.get_user!(String.to_integer(user_id))

    contributors_id = project
    |> Map.get(:contributors)
    |> Enum.concat([user])
    |> Enum.map(fn u -> u.id end)

    update_project(socket, project, %{"contributors_id" => contributors_id })
  end

  def handle_info({"projects", [:projects, :updated], project}, socket) do
    socket =
      socket
      |> assign(:project, project)

    {:noreply, socket}
  end

  defp update_project(socket, %Project{} = project, params \\ %{}) do
    case CMS.update_project(project, params) do
      {:ok, project} ->
        {:noreply,
        socket
        |> put_flash(:info, "Project updated !")
        |> assign(:page_title, page_title(socket.assigns.live_action))
        |> assign(:project, project)}
      {:error, _} ->
        {:noreply,
         socket
         |> put_flash(:error, "Error updating project")
         |> assign(:page_title, page_title(socket.assigns.live_action))
         |> assign(:project, project)}
    end
  end

  defp page_title(:show), do: "Show Project"
  defp page_title(:edit), do: "Edit Project"
  defp page_title(:upload), do: "Upload Material"

  def is_contributor(%Project{} = project, %User{} = user) do
    project
    |> Map.get(:contributors)
    |> Enum.any?(fn(u) ->
      u.id == user.id
    end)
  end
end
