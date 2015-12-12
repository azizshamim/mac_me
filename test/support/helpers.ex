defmodule MacMe.Test.Support.Helpers do
  def launch_api do
    endpoint_config =
      Application.get_env(:mac_me, MacMe.Endpoint)
    |> Keyword.put(:server, true)

    :ok = Application.put_env(:mac_me, MacMe.Endpoint, endpoint_config)
    :ok = Application.stop(:mac_me)
    :ok = Application.start(:mac_me)
  end
end
