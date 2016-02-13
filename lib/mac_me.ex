defmodule MacMe do
  @moduledoc """
  Provides a mechanism to detect what users are in the immediate vicinity,
  Accomplished by mapping owned devices (MAC address). Scans for all active
  devices on the wire (and WiFi -- future) and de-references against a known
  DB of devices to users.
  """

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(MacMe.Endpoint, []),
      supervisor(MacMe.DeviceSupervisor, []),
      supervisor(MacMe.DatabaseSupervisor, [])
    ]

    opts = [strategy: :one_for_one, name: Supervisor]
    {:ok, _} = Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MacMe.Endpoint.config_change(changed, removed)
    :ok
  end
end
