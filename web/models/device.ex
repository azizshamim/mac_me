defmodule MacMe.Device do
  @moduledoc """
  This module defines the model for a Device, as it is stored in the database
  """

  defstruct [:mac_address, :name]

  @mac_format ~r/([0-9A-F]{2}[:-]){5}([0-9A-F]{2})/

end
