defmodule MacMe.V1.DeviceView do
  @moduledoc """
  Representation of the data structures that make it back to the user for
  Devices
  """
  use MacMe.Web, :view

  def render("index.json", %{devices: devices}) do
    %{data: render_many(devices, MacMe.V1.DeviceView, "device.json")}
  end

  def render("show.json", %{device: device}) do
    %{data: render_one(device, MacMe.V1.DeviceView, "device.json")}
  end

  def render("device.json", %{device: device}) do
    device
  end
end
