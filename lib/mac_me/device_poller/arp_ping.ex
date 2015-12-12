defmodule MacMe.DevicePoller.ArpPing do
  def run(subnets) do
    try do
      {output, _} = System.cmd("arp-scan", [subnets])

      output |> MacMe.Support.Helpers.extract_mac
    rescue
      e -> {:error, e}
    end
  end
end
