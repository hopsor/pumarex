defmodule Pumarex.Web.LayoutView do
  use Pumarex.Web, :view

  def websocket_url() do
    Application.get_env(:pumarex, :websocket_url)
  end
end
