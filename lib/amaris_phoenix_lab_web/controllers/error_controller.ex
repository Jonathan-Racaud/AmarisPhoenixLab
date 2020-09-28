defmodule AmarisPhoenixLabWeb.ErrorController do
  use AmarisPhoenixLabWeb, :controller

  def not_found(conn, _params) do
    render(conn, "404.html")
  end
end
