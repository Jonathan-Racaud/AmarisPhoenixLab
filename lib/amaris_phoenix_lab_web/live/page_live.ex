defmodule AmarisPhoenixLabWeb.PageLive do
  use AmarisPhoenixLabWeb, :live_view
  import AmarisPhoenixLab.Authorization
  alias AmarisPhoenixLabWeb.Credentials

  @impl true
  def mount(_params, session, socket) do
    current_user = Credentials.get_user(socket, session)
    {:ok, assign(socket, current_user: current_user)}
  end
end
