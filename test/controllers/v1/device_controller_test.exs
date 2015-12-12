defmodule MacMe.V1.DeviceControllerTest do
  use MacMe.ConnCase

  alias MacMe.Device
  @valid_attrs %{mac_address: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_device_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    device = Repo.insert! %Device{}
    conn = get conn, v1_device_path(conn, :show, device)
    assert json_response(conn, 200)["data"] == %{"id" => device.id,
      "mac_address" => device.mac_address,
      "user_id" => device.user_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_device_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_device_path(conn, :create), device: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Device, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_device_path(conn, :create), device: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    device = Repo.insert! %Device{}
    conn = put conn, v1_device_path(conn, :update, device), device: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Device, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    device = Repo.insert! %Device{}
    conn = put conn, v1_device_path(conn, :update, device), device: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    device = Repo.insert! %Device{}
    conn = delete conn, v1_device_path(conn, :delete, device)
    assert response(conn, 204)
    refute Repo.get(Device, device.id)
  end
end
