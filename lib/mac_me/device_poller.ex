defmodule MacMe.DevicePoller do
  use GenServer

  @scannedSubnets Application.get_env(:mac_me, :scanned_subnets)
  @devicePoller Application.get_env(:mac_me, :device_poller)
  @pollInterval Application.get_env(:mac_me, :poll_interval)

  # Public API
  def start_link(device_data_pid) do
    GenServer.start_link(__MODULE__, device_data_pid, name: __MODULE__)
  end

  # GenServer
  def init(device_data_pid) do
    devices = poll_for_devices(device_data_pid)

    Process.send_after(device_data_pid, :poll, @pollInterval)
    {:ok, {devices, device_data_pid}}
  end

  def handle_info(:poll, {_devices, device_data_pid}) do
    devices = poll_for_devices(device_data_pid)

    Process.send_after(device_data_pid, :poll, @pollInterval)
    {:noreply, {devices, device_data_pid}}
  end

  # Private API
  defp poll_for_devices(device_data_pid) do
    devices = @devicePoller.run(@scannedSubnets)
    MacMe.DeviceData.save_state(device_data_pid, devices)

    devices
  end
end
