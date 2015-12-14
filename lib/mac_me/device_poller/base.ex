defmodule MacMe.DevicePoller.Base do
  @moduledoc """
  Base behavior required for use as a device poller. Maybe overkill,
  but uses Behaviors to get a handle on the concept
  """
  use Behaviour

  @doc "Performs a scan against the supplied subnets"
  defcallback run(list) :: list
end
