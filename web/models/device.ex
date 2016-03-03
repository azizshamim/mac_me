defmodule MacMe.Device do
  @moduledoc """
  This module defines the model for a Device, as it is stored in the database
  """

  defstruct mac_address: nil, name: nil
  use Vex.Struct

  @mac_format ~r/([0-9A-F]{2}[:-]){5}([0-9A-F]{2})/

  validates :mac_address,
    presence: true,
    format: @mac_format,
    message: "Invalid MAC address"
end
