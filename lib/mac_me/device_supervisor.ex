defmodule MacMe.DeviceSupervisor do
  @moduledoc """
  Supervisor responsible for polling for active devices based on MAC
  address, and keeping them available in cache for the application
  to do fun/cool things.
  """
  use Supervisor

  @name MacMe.DeviceSupervisor
  @poller_cache MacMe.DevicePollerCache
  @poller_supervisor MacMe.DevicePollerSupervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def init(_) do
    children = [
      worker(@poller_cache, []),
      supervisor(@poller_supervisor, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
