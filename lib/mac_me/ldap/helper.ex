require IEx

defmodule MacMe.LDAP.Helper do
  alias MacMe.LDAP.Helper
  alias MacMe.LDAP.Connection

  def add({:ou, dn}, _) do
    ou = Helper.basename(dn)
    attributes = [
      {'objectClass', ['organizationalUnit', 'top']},
      {'ou', [ou]}
    ]

    :ok = Connection.add(dn, attributes)
  end

  def add(dn, attributes \\ []) do
    type =
      Helper.basename(dn, :type)
    |> String.to_atom

    Helper.add({type, dn}, attributes)
  end

  def basename(dn, :type) do
    dn
    |> Helper.base_dn
    |> String.split("=")
    |> List.first
  end

  def basename(dn) do
    dn
    |> Helper.base_dn
    |> String.split("=")
    |> List.last
  end

  def base_dn(dn) do
    dn
    |> String.split(",")
    |> List.first
  end

  def search(dn) do
    type = Helper.basename(dn, :type) |> String.to_char_list
    filter = [
      :eldap.present(type)
    ]

    Connection.search(dn, filter)
  end

  def exists?(dn) do
    case Helper.search(dn) do
      {:ok, :eldap_search_result, _} -> true
      {:error, _} -> false
    end
  end
end
