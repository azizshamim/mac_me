defmodule MacMe do
  @moduledoc """
  Provides a mechanism to detect what users are in the immediate vicinity,
  Accomplished by mapping owned devices (MAC address). Scans for all active
  devices on the wire (and WiFi -- future) and de-references against a known
  DB of devices to users.

  Two supervisors in play: Main and Backend. Main handles Phoenix and friends,
  while the Backend is responsible for ARP and WiFi scanning.
  """

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(MacMe.Endpoint, []),
      worker(MacMe.Repo, []),
      worker(MacMe.BackendSupervisor, []),
    ]

    opts = [strategy: :one_for_one, name: MacMe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MacMe.Endpoint.config_change(changed, removed)
    :ok
  end
end
