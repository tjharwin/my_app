defmodule MyApp.LogServer do
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    send(self(), :refresh)
    {:ok, state}
  end

  def handle_info(:refresh, state) do
    print_log()
    sleep()
    {:noreply, state}
  end

  def print_log() do
    Logger.info("This is my log that I'm going to print every second")
  end

  def sleep() do
    Logger.info("Sleep for 1 sec...")

    Process.send_after(self(), :refresh, 1000)
  end
end
