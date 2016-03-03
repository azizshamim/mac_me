defmodule MacMe.DeviceTest do
  use ExUnit.Case

  @valid_attrs %{
    mac_address: "02:E6:50:42:F4:00",
    name: "batphone",
  }

  @invalid_attrs %{
    mac_address: "not_a_mac",
  }

  # test "a valid mac address should be good to go" do
  #   device = Ma
  #   device = MacMe.Device.new(@valid_attrs)
  #   assert MacMe.Device.valid? device
  # end

  # test "an invalid mac addcess should not be accepted" do
  #   device = MacMe.Device.new(@invalid_attrs)
  #   refute MacMe.Device.valid? device
  # end

  # test "will refuse MAC addresses without leading zeroes" do
  #   data = Dict.put(@valid_attrs, :mac_address, "2:E6:5:42:F4:0")
  #   device = MacMe.Device.new(data)
  #   refute MacMe.Device.valid? device
  # end

  # test "will refuse lowercase MAC addresses" do
  #   data = Dict.put(@valid_attrs, :mac_address, "2:e6:5:42:f4:0")
  #   device = MacMe.Device.new(data)
  #   refute MacMe.Device.valid? device
  # end
end
