defmodule MacMe do
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
