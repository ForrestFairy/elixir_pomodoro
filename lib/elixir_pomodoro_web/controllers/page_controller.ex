defmodule ElixirPomodoroWeb.PageController do
  use ElixirPomodoroWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
