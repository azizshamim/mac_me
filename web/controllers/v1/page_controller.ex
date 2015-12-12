defmodule MacMe.V1.PageController do
  use MacMe.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
