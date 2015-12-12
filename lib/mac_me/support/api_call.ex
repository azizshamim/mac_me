# Taken from http://dantswain.herokuapp.com/blog/2015/04/19/integration-testing-a-json-api-in-phoenix/
# Thanks Dan!
defmodule MacMe.Support.APICall do
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
