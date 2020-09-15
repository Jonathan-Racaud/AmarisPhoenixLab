defmodule AmarisPhoenixLabWeb.AdminLive.Index do
  use AmarisPhoenixLabWeb, :live_view
  alias AmarisPhoenixLabWeb.Credentials
  alias AmarisPhoenixLab.{CMS, Users}

  @impl true
  def mount(_params, session, socket) do
    current_user = Credentials.get_user(socket, session)

    {:ok,
      socket
      |> assign(current_user: current_user)
      |> assign(projects: CMS.list_projects())
      |> assign(users: Users.list_users())}
  end
end
