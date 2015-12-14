defmodule MacMe.Support.APICall do
  @moduledoc """
  Module used during dev, test, and prod to make internal calls to self
  via the API. Automatically sends a command properly formatted and
  targeted for the correct endpoint.

  Shamelessly adapted Dan Swain's testing pattern. Thanks Dan!
  http://bit.ly/1RLBr5q <- (Real, promise. Just hate lint errors!)
  """
  use HTTPoison.Base

  def process_url(url) do
    api_url <> url
  end

  def process_body(body) do
    try do
      Poison.decode!(body, keys: :atoms!)
    rescue
      _ -> body
    end
  end

  def process_request_body(body) do
    Poison.encode!(body)
  end

  def process_request_headers(headers) do
    [{'content-type', 'application/json'} | headers]
  end

  # Private Lookup
  defp api_url do
    endpoint_config = Application.get_env(:mac_me, MacMe.Endpoint)
    host = Keyword.get(endpoint_config, :url) |> Keyword.get(:host)
    port = Keyword.get(endpoint_config, :http) |> Keyword.get(:port)

    "http://#{host}:#{port}/api/v1"
  end
end
