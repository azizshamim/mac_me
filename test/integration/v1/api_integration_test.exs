require IEx

defmodule MacMe.V1.ApiIntegrationTest do
  use ExUnit.Case

  alias MacMe.Test.Support.APICall
  alias MacMe.Test.Support.Fixtures

  setup_all do
    MacMe.Test.Support.TestHelpers.launch_api
    :ok
  end

  test "register a new user" do
    random_user = Fixtures.user
    response = APICall.post!("/users/register", random_user)

    assert response.status_code == 200
    assert response.body == %{status: 'OK', result: random_user} |> Poison.encode!
  end
end

#  test "show detected devices and associated users" do
#    device_data_pid = :erlang.whereis MacMe.DeviceData
#    devices = MacMe.DeviceData.get_state(device_data_pid)
#
#    response = APICall.get!("/")
#    expected_response = devices |> Poison.encode!
#
#    assert response.status_code == 200
#    assert response.body == expected_response
#  end

#  test "have an existing user claim a device" do
#    user = 'jamison'
#    mac = 'aa:bb:cc:dd::ee::ff'
#    response = APICall.post!("/device/claim", {user: user, mac: mac})
#
#    assert response.status_code == 200
#    assert response.body == [] |>
#
#  end

#  test "have a new user claim a device" do
#    user = 'billybob'
#    mac = 'aa:bb:cc:dd::ee::11'
#    response = APICall.post!("/device/claim", {user: user, mac: mac})
#
#    presence = APICall.get!("/")
#
#    assert response.status_code == 200
#    assert response.body == presence |> Poison.encode!
#  end
