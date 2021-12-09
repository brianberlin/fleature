defmodule FleatureWeb.PageController do
  use FleatureWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
