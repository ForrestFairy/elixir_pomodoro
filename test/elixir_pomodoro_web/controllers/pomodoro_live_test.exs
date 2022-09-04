defmodule ElixirPomodoroWeb.PomodoroLiveTest do
  use ElixirPomodoroWeb.ConnCase

  import Phoenix.LiveViewTest

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "This is your pomodoro:"
  end

  test "Using START button", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert render_click(view, :start, %{}) =~ "This is your pomodoro:"
  end

  # test "check if STOP is working" do
  #   {:ok, view, _html} = live(conn, "/")


  # end
end
