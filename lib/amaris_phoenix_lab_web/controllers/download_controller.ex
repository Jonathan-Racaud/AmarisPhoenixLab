defmodule AmarisPhoenixLabWeb.DownloadController do
  use AmarisPhoenixLabWeb, :controller
  alias AmarisPhoenixLab.CMS

  def get_file(conn, %{"material_id" => material_id} = _params) do
    material = CMS.get_material!(material_id)
    path = material.source
    filename = Path.basename(material.source)
    content_type = material.content_type

    conn
    |> put_resp_content_type(content_type)
    |> put_resp_header("content-disposition", "attachment; filename=#{filename}")
    |> send_file(200, path)
  end
end
