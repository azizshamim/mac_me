defmodule MacMe.Device do
  @moduledoc """
  This module defines the model for a Device, as it is stored in the database
  """

  alias MacMe.LDAP.Connection
  defstruct [:mac_address, :name]

  @mac_format ~r/([0-9A-F]{2}[:-]){5}([0-9A-F]{2})/

  def new(%{mac_address: mac_address, name: name}) do
    %MacMe.Device{
      mac_address: mac_address,
      name: name
    }
  end

  def new(%{mac_address: mac_address}) do
    %MacMe.Device{mac_address: mac_address}
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
    if valid?(device) do
      :ok
    else
      {:error, "Invalid MAC address"}
    end
  end

  def device_exists?(mac_address) do
    case search_by({:mac_address, mac_address}) do
      [] -> false
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
