defmodule MacMe.DevicePollerSupervisor do
  use Supervisor

  @devicePoller MacMe.DevicePoller

  def start_link(device_data_pid) do
    Supervisor.start_link(__MODULE__, device_data_pid, name: __MODULE__)
  end

  def init(device_data_pid) do
    children = [
      worker(@devicePoller, [device_data_pid])
    ]

    {:ok, _} = supervise(children, strategy: :one_for_one)
  end
end
