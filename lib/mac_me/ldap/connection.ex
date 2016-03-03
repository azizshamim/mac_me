require IEx

defmodule MacMe.LDAP.Connection do
  defmodule State do
    defstruct handle: nil, hosts: nil, port: nil, ssl: nil, bind_dn: nil, base_dn: nil
  end

  use GenServer
  require Logger

  @name MacMe.LDAP.Connection

  ## Public API
  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

  def search(dn) when is_binary(dn), do: search(to_char_list(dn))
  def search(dn) do
    GenServer.call(__MODULE__, {:search, dn})
  end

  def add(dn, attributes) when is_binary(dn), do: add(to_char_list(dn), attributes)
  def add(dn, attributes) do
    GenServer.call(__MODULE__, {:add, dn, attributes})
  end

  def update(dn, attributes) when is_binary(dn), do: update(to_char_list(dn), attributes)
  def update(dn, attributes) do
    GenServer.call(__MODULE__, {:modify, dn, attributes})
  end

  def delete(dn) when is_binary(dn), do: delete(to_char_list(dn))
  def delete(dn) do
    GenServer.call(__MODULE__, {:delete, dn})
  end

  ## GenServer API
  def init(:ok) do
    state = %State{
      hosts: config(:hosts),
      port: config(:port),
      ssl: config(:ssl),
      bind_dn: config(:bind_dn),
      base_dn: config(:base_dn)
    }

    {:ok, handle} =
      :eldap.open(state.hosts, [{:port, state.port}, {:ssl, state.ssl}])
    :ok == :eldap.simple_bind(handle, state.bind_dn, config(:password))

    if config(:tls), do: :ok == :eldap.start_tls(handle)

    # NOTE: Do not care for the reassignment here, only in name of readability.
    #       Is there a more idiomatic way to do this?
    #       - JDF / 20160202
    state = %State{state | handle: handle}
    {:ok, state}
  end

  def handle_call({:add, dn, attributes}, _from, state) do
    :ok == :eldap.add(state.handle, dn, attributes)

    {:reply, :ok, state}
  end

  def handle_call({:search, dn}, _from, state) do
    type = dn
    |> MacMe.LDAP.Helper.basename(:type)
    |> String.to_char_list

    search = :eldap.search(state.handle, [
          {:scope, :eldap.baseObject},
          {:filter, :eldap.present(type)},
          {:base, dn},
        ])

    case search do
      {:ok, {:eldap_search_result, results}}
      =    -> {:reply, results, state}
    end
  end

  def handle_call({:modify, dn, modify_op}, _from, state) do
    :ok == :eldap.modify(state.handle, dn, modify_op)

    {:reply, :ok, state}
  end

  def handle_call({:delete, dn}, _from, state) do
    :ok == :eldap.delete(state.handle, dn)

    {:reply, :ok, state}
  end

  def terminate(_reason, state) do
    :ok == :eldap.close(state.handle)
  end

  def handle_info(_msg, state), do: {:noreply, state}

  ## Private Configuration Methods
  defp config(parameter) do
    Application.get_env(:mac_me, MacMe.LDAP)
    |> Keyword.get(parameter, false)
  end
end
