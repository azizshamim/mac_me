defmodule MacMe.DatabaseSupervisor do
  @moduledoc """
  Supervisor responsible for polling for active devices based on MAC
  address, and keeping them available in cache for the application
  to do fun/cool things.
  """
  use Supervisor

  @name MacMe.DatabaseSupervisor
  @ldap_handler MacMe.LDAP.Connection

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def init(_) do
    children = [
      worker(@ldap_handler, []),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
