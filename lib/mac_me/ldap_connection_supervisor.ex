defmodule MacMe.LDAP.ConnectionSupervisor do
  @moduledoc """
  Supervisor module responsible for maintaining the connection to LDAP
  """
  use Supervisor

  def start_link(device_data_pid) do
    Supervisor.start_link(__MODULE__, device_data_pid, name: __MODULE__)
  end

  def init(device_data_pid) do
    children = [
      worker(MacMe.LDAP.Connection, [])
    ]

    {:ok, _} = supervise(children, strategy: :one_for_one)
  end
end
