defmodule MacMe.DeviceTest do
  use MacMe.ModelCase

  alias MacMe.Device

  test "an invalid mac addcess should not be accepted" do
    data = %{mac_address: "not_a_mac"}
    changeset = Device.changeset(%Device{}, data)
    refute changeset.valid?
  end

  test "a valid mac address should be good to go" do
    data = %{mac_address: "02:E6:50:42:F4:00"}
    changeset = Device.changeset(%Device{}, data)
    assert changeset.valid?
  end

  test "will refuse MAC addresses without leading zeroes" do
    data = %{mac_address: "2:E6:5:42:F4:0"}
    changeset = Device.changeset(%Device{}, data)
    refute changeset.valid?
  end

  test "will refuse lowercase MAC addresses" do
    data = %{mac_address: "2:e6:5:42:f4:0"}
    changeset = Device.changeset(%Device{}, data)
    refute changeset.valid?
  end
end
