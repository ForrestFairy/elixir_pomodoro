defmodule ElixirPomodoro.Timer do

  def basic() do
    {:ok, time} = Time.new(0, 25, 0)
    time
  end

  def break() do
    {:ok, time} = Time.new(0, 5, 0)
    time
  end

  def show(time) do
    {_hours, rest} = String.split_at(Time.to_string(Time.truncate(time, :second)), 3)
    rest
  end
end
