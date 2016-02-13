require IEx

defmodule MacMe.DevicePoller do
  @moduledoc """
  This is a factory module that wraps GenServer with a pluggable
  backend polling module. This is for testing, as well as future growth and
  expansion of the methods used for gathering up devices from the network.

  Grabs the poller type from config. Takes advantage of Elixir
  Behaviors to ensure consistent application of future polling modules.
  """

  use GenServer

  @name MacMe.DevicePoller
  @poller_cache MacMe.DevicePollerCache
  @scanned_subnets Application.get_env(:mac_me, :scanned_subnets)
  @device_poller Application.get_env(:mac_me, :device_poller)
  @poll_interval Application.get_env(:mac_me, :poll_interval)

  # Public API
  def start_link do
    GenServer.start_link(__MODULE__, @poller_cache, name: @name)
  end

  # GenServer
  def init(_) do
    devices = poll_for_devices

    Process.send_after(@poller_cache, :poll, @poll_interval)
    {:ok, devices}
  end

  def handle_info(:poll, {_devices}) do
    devices = poll_for_devices

    Process.send_after(@poller_cache, :poll, @poll_interval)
    {:noreply, devices}
  end

  # Private API
  defp poll_for_devices do
    devices = @device_poller.run(@scanned_subnets)
    MacMe.DevicePollerCache.save_state(@poller_cache, devices)

    devices
  end
end
