defmodule MyApp.LogServer do
  use GenServer
  require Logger
  require Integer

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
    Logger.info("This is my log that I'm going to print every 60 seconds")
    print_error?()
  end

  def print_error?() do
    minute = DateTime.now!("Etc/UTC").minute

    if Integer.is_even(minute) do
      Logger.error("Cor blimey gov'ner, we got ourselves an error")
    end
  end

  def sleep() do
    Logger.info("Sleep for 10 secs...")
    Process.send_after(self(), :refresh, 60000)
  end
end
