defmodule MacMe.DevicePollerSupervisor do
  @moduledoc """
  Supervisor module keeping the device polling up and happy
  """
  use Supervisor

  @name MacMe.DevicePollerSupervisor
  @device_poller MacMe.DevicePoller

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def init(_) do
    children = [
      worker(@device_poller, [])
    ]

    {:ok, _} = supervise(children, strategy: :one_for_one)
  end
end
