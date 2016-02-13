defmodule MacMe.Database.LDAPHandler do
  use GenServer

  @name MacMe.Database.LDAPHandler

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

  # GenServer API
  def init(:ok) do
    {:ok, %{}}
  end

  def terminate(_reason, _state) do
    :ok
  end


  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
