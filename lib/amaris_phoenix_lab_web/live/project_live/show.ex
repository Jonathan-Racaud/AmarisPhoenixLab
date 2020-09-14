defmodule AmarisPhoenixLabWeb.ProjectLive.Show do
  use AmarisPhoenixLabWeb, :live_view

  alias AmarisPhoenixLab.{CMS, CMS.Project, CMS.Material}
  alias AmarisPhoenixLab.{Users, Users.User}
  alias AmarisPhoenixLabWeb.Credentials

  @impl true
  def mount(_params, session, socket) do
    current_user = Credentials.get_user(socket, session)
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

    contributors = project
    |> Map.get(:contributors)
    |> Enum.reject(fn(u) -> u.id == user.id end)

    project = CMS.update_project(project, %{contributors: contributors})

    {:noreply,
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:project, project)}
  end

  @impl true
  def handle_event("join_project", %{"user" => user_id, "value" => _}, socket) do
    project = socket.assigns.project
    user = Users.get_user!(String.to_integer(user_id))

    contributors = project
    |> Map.get(:contributors)
    |> Enum.concat([user])

    project = CMS.update_project(project, %{contributors: contributors})

    {:noreply,
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:project, project)}
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
