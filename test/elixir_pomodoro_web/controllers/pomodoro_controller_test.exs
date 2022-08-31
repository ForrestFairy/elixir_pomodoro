defmodule ElixirPomodoroWeb.PomodoroLiveTest do
  use ElixirPomodoroWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "This is your pomodoro:"
  end
end
