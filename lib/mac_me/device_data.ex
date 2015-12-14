defmodule MacMe.DeviceData do
  @moduledoc """
  This process provides a container to hold cached state of devices found.
  DevicePoller will drop data into this process to hold state in the event
  of failure of the poller.

  Pretty standard GenServer public/private pattern. Used GenServer versus
  Agents just to get a feel for things.
  """
  use GenServer

  # Public API
  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def save_state(pid, state) do
    GenServer.cast(pid, {:save_state, state})
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  # GenServer API
  def init(devices) do
    {:ok, devices}
  end

  def handle_call(:get_state, _from, current_state) do
    {:reply, current_state, current_state}
  end

  def handle_cast({:save_state, new_state}, _current_state) do
    {:noreply, new_state}
  end
end
