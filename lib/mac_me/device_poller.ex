defmodule MacMe.DevicePoller do
  @moduledoc """
  This is a factory module that wraps GenServer with a pluggable
  backend polling module. This is for testing, as well as future growth and
  expansion of the methods used for gathering up devices from the network.

  Grabs the poller type from config. Takes advantage of Elixir
  Behaviors to ensure consistent application of future polling modules.
  """

  use GenServer

  @scanned_subnets Application.get_env(:mac_me, :scanned_subnets)
  @device_poller Application.get_env(:mac_me, :device_poller)
  @poll_interval Application.get_env(:mac_me, :poll_interval)

  # Public API
  def start_link(device_data_pid) do
    GenServer.start_link(__MODULE__, device_data_pid, name: __MODULE__)
  end

  # GenServer
  def init(device_data_pid) do
    devices = poll_for_devices(device_data_pid)

    Process.send_after(device_data_pid, :poll, @poll_interval)
    {:ok, {devices, device_data_pid}}
  end

  def handle_info(:poll, {_devices, device_data_pid}) do
    devices = poll_for_devices(device_data_pid)

    Process.send_after(device_data_pid, :poll, @poll_interval)
    {:noreply, {devices, device_data_pid}}
  end

  # Private API
  defp poll_for_devices(device_data_pid) do
    devices = @device_poller.run(@scanned_subnets)
    MacMe.DeviceData.save_state(device_data_pid, devices)

    devices
  end
end
