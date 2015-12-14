defmodule MacMe.Test.Support.Helpers do
  @moduledoc """
  Helper functions used during testing that don't have a home otherwise
  """
  def launch_api do
    endpoint_config =
      Application.get_env(:mac_me, MacMe.Endpoint)
      |> Keyword.put(:server, true)

    :ok = Application.put_env(:mac_me, MacMe.Endpoint, endpoint_config)
    :ok = Application.stop(:mac_me)
    :ok = Application.start(:mac_me)
  end
end
