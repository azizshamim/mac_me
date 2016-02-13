require IEx

defmodule MacMe.DeviceTest do
  use ExUnit.Case

  alias MacMe.Device

  @valid_attrs %{
    mac_address: "02:E6:50:42:F4:00",
    name: "batphone",
  }

  @invalid_attrs %{
    mac_address: "not_a_mac",
  }

  test "an invalid mac addcess should not be accepted" do
    device = Device.new(@invalid_attrs)
    IEx.pry
    assert Device.save(device) == {:error, "Invalid MAC address"}
  end

  test "a valid mac address should be good to go" do
    device = Device.new(@valid_attrs)
    assert Device.save(device) == :ok
  end

  test "will refuse MAC addresses without leading zeroes" do
    data = Dict.put(@valid_attrs, :mac_address, "2:E6:5:42:F4:0")
    device = Device.new(data)
    assert Device.save(device) == {:error, "Invalid MAC address"}
  end

  test "will refuse lowercase MAC addresses" do
    data = Dict.put(@valid_attrs, :mac_address, "2:e6:5:42:f4:0")
    device = Device.new(data)
    assert Device.save(device) == {:error, "Invalid MAC address"}
  end
end
