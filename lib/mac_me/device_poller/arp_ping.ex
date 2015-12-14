defmodule MacMe.DevicePoller.ArpPing do
  @moduledoc """
  Scans for devices by spawning `arp-scan` process and grabbing
  all a subnet.

  Currently only supports a single subnet.
  """
  @behaviour MacMe.DevicePoller.Base

  def run(subnets) do
    try do
      {output, _} = System.cmd("arp-scan", [subnets])

      output |> MacMe.Support.Helpers.extract_mac
    rescue
      e -> {:error, e}
    end
  end
end
