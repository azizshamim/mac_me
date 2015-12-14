defmodule MacMe.BackendSupervisor do
  @moduledoc """
  Supervisor responsible for polling for active devices based on MAC
  address, and keeping them available in cache for the application
  to do fun/cool things.

  Uses a Data Process (DeviceData) and a secondary Poller Supervisor
  in tandem to scan/save data
  """
  use Supervisor

  @data_worker MacMe.DeviceData
  @poller_supervisor MacMe.DevicePollerSupervisor

  def start_link do
    result = {:ok, supervisor_pid} = Supervisor.start_link(__MODULE__, :ok,
                                                           name: __MODULE__)
    start_workers(supervisor_pid)
    result
  end

  def start_workers(supervisor_pid) do
    # Start device-data worker for ephemeral data store
    {:ok, device_data_pid} = Supervisor.start_child(supervisor_pid,
                                                    worker(@data_worker, []))

    # Start Sub-Supervisor for Device Poller
    {:ok, _} = Supervisor.start_child(supervisor_pid, worker(@poller_supervisor,
                                                             [device_data_pid]))
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end
