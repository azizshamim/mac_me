defmodule MacMe.V1.DeviceControllerTest do
  use MacMe.ConnCase

  @valid_attrs %{mac_address: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end
end
