defmodule AmarisPhoenixLabWeb.Authorize do
  import Plug.Conn
  import Phoenix.Controller
  import AmarisPhoenixLab.Authorization
  alias AmarisPhoenixLabWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, opts) do
    role = conn.assigns.current_user.role
    resource = Keyword.get(opts, :resource)
    action = action_name(conn)

    check(action, role, resource)
    |> maybe_continue(conn)
  end

  defp maybe_continue(true, conn), do: conn
  defp maybe_continue(false, conn) do
    conn
    |> put_flash(:error, "Not authorized")
    |> redirect(to: Routes.page_path(conn, :index))
    |> halt()
  end

  defp check(:index, role, resource) do
    can(role) |> read?(resource)
  end

  defp check(action, role, resource) when action in [:new, :create] do
    can(role) |> create?(resource)
  end

  defp check(action, role, resource) when action in [:edit, :update] do
    can(role) |> update?(resource)
  end

  defp check(:delete, role, resource) do
    can(role) |> delete?(resource)
  end

  defp check(_, _, _), do: false
end
