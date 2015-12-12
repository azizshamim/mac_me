defmodule MacMe.V1.DeviceView do
  use MacMe.Web, :view

  def render("index.json", %{devices: devices}) do
    %{data: render_many(devices, MacMe.DeviceView, "device.json")}
  end

  def render("show.json", %{device: device}) do
    %{data: render_one(device, MacMe.DeviceView, "device.json")}
  end

  def render("device.json", %{device: device}) do
    %{id: device.id,
      mac_address: device.mac_address,
      user_id: device.user_id}
  end
end
