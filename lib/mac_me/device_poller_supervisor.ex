defmodule MacMe.DevicePollerSupervisor do
  @moduledoc """
  Supervisor module keeping the device polling up and happy
  """
  use Supervisor

  @device_poller MacMe.DevicePoller

  def start_link(device_data_pid) do
    Supervisor.start_link(__MODULE__, device_data_pid, name: __MODULE__)
  end

  def init(device_data_pid) do
    children = [
      worker(@device_poller, [device_data_pid])
    ]

    {:ok, _} = supervise(children, strategy: :one_for_one)
  end
end
