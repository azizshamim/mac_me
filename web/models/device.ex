defmodule MacMe.Device do
  @moduledoc """
  This module defines the model for a Device, as it is stored in the database
  """

  alias MacMe.LDAP.Connection
  alias MacMe.Device
  defstruct [:mac_address, :name]

  @mac_format ~r/([0-9A-F]{2}[:-]){5}([0-9A-F]{2})/

  def new(%{mac_address: mac_address, name: name}) do
    %Device{
      mac_address: mac_address,
      name: name
    }
  end

  def new(%{mac_address: mac_address}) do
    %Device{mac_address: mac_address}
  end

  def mac_address(device) do
    device.mac_address
  end

  def name(device) do
    device.name
  end

  def valid?(device) do
    cond do
      String.match?(device.mac_address, @mac_format) -> true
      true -> false
    end
  end

  def save(device) do
    cond do
      Device.valid?(device) -> Device.save_db(:add, device)
      true -> {:error, "Invalid MAC address"}
    end
  end

  def save_db(:update, device) do
    :ok
  end

  def save_db(:add, device) do
    :ok
  end

  def exists?(mac_address) do
    case Device.search_by({:mac_address, mac_address}) do
      {:error, :noSuchObject} -> false
      true -> true
    end
  end

  def search_by({:mac_address, mac_address}) do
    search_filter = :eldap.equalityMatch('cn', mac_address)
    search_by({:filter, search_filter})
  end

  def search_by({:name, name}) do
    search_filter = :eldap.equalityMatch('sn', name)
    search_by({:filter, search_filter})
  end

  def search_by({:filter, filter}) do
    {type, user, attributes} = Connection.search(filter)
    {user, attributes}
  end
end
