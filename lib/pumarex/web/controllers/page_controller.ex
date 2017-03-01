defmodule Pumarex.Web.PageController do
  use Pumarex.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
