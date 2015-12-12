defmodule MacMe.Support.Helpers do
  def extract_mac(string) do
    string
    |> String.split(["\n", "\t"])
    |> Enum.filter(&(&1 =~ ~r/([0-9a-f]{1,2}[\.:-]){5}([0-9a-f]{1,2})/))
  end
end
