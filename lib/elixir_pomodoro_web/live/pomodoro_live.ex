defmodule ElixirPomodoroWeb.PomodoroLive do
  use ElixirPomodoroWeb, :live_view
  alias ElixirPomodoro.Timer

  @second 1
  @minute 60

  def mount(_params, _session, socket) do


    socket = assign(socket,
      timer: 0,
      time: Timer.basic(),
      break: false,
      active: false
      )
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>This is your pomodoro:</h1>
    <div id="timer"><%= Timer.show(@time) %></div> <button phx-click="start">Start</button>
    <%= if @break do %>
      <button phx-click="break">Break?</button>
    <% end %>
    <%= if @active do %>
      <br>
      <button phx-click="pause">Pause</button>
    <% end %>
    """
  end

  def handle_event("start", _, socket) do
    {:ok, timer} = :timer.send_interval(1000, self(), :tick)
    socket = socket
    |> assign(:timer, timer)
    |> assign(:active, true)
    {:noreply, socket}
  end

  def handle_event("break", _, socket) do
    socket = socket
    |> assign(socket, time: Timer.break())
    |> assign(socket, active: true)
    send(self(), :start)
    {:noreply, socket}
  end

  def handle_event("pause", _, socket) do
    socket = assign(socket, :active, false)
    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    # Time change here ---
    case socket.assigns.active do
      true ->
        socket = update(socket, :time, &(Time.add(&1, -@second)))
        cond do
            Time.compare(socket.assigns.time, ~T[00:00:00]) == :eq ->
              :timer.cancel(socket.assigns.timer)
              send(self(), :stop)
              {:noreply, socket}
            true ->
              {:noreply, socket}
        end
      false ->
        :timer.cancel(socket.assigns.timer)
        {:noreply, socket}
    end


  end

  def handle_info(:stop, socket) do
    socket = assign(socket, time: Timer.basic(), break: not socket.assigns.break)
    {:noreply, socket}
  end

  def handle_info(:start, socket) do
    {:ok, timer} = :timer.send_interval(1000, self(), :tick)
    socket = assign(socket, :timer, timer)
    {:noreply, socket}
  end
end
