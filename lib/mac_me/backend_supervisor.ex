defmodule MacMe.BackendSupervisor do
  use Supervisor

  @dataWorker MacMe.DeviceData
  @pollerSupervisor MacMe.DevicePollerSupervisor

  def start_link do
    result = {:ok, supervisor_pid} = Supervisor.start_link(__MODULE__, :ok,
                                                           name: __MODULE__)
    start_workers(supervisor_pid)
    result
  end

  def start_workers(supervisor_pid) do
    # Start device-data worker for ephemeral data store
    {:ok, device_data_pid} = Supervisor.start_child(supervisor_pid,
                                                    worker(@dataWorker, []))

    # Start Sub-Supervisor for Device Poller
    {:ok, _} = Supervisor.start_child(supervisor_pid, worker(@pollerSupervisor,
                                                             [device_data_pid]))
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end
