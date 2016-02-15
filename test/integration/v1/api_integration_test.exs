require IEx

defmodule MacMe.V1.ApiIntegrationTest do
  use ExUnit.Case

  setup_all do
    MacMe.Test.Support.Helpers.launch_api
    :ok
  end

  # test "register a new user" do
  #   random_user = Fixtures.user
  #   payload = %{
  #     "user" => random_user,
  #   }
  #   response = APICall.post!("/users", payload)
  #   expected_status_code = 201

  #   assert response.status_code == expected_status_code
  # end

  # test "update a user avatar_url" do
  #   # First, let's create a new user. Relies on previous
  #   # test creating a user doing its thing.
  #   random_user = Fixtures.user
  #   create_user_payload = %{
  #     "user" => random_user,
  #   }
  #   created_user = APICall.post!("/users", create_user_payload)

  #   user_id = created_user.body
  #   |> Poison.decode!
  #   |> Dict.get("data")
  #   |> Dict.get("id")

  #   # Oh wait, I'd rather use this avatar instead!
  #   expected_status_code = 200
  #   update_avatar_payload = %{
  #     "user" => %{
  #       avatar_url: Faker.Internet.image_url
  #     }
  #   }

  #   updated_user = APICall.put!("/users/#{user_id}",
  #                                update_avatar_payload)

  #   assert updated_user.status_code == expected_status_code
  # end

  # test "show a list of all devices currently detected" do
  #   device_data_pid = :erlang.whereis MacMe.DeviceData
  #   devices = MacMe.DeviceData.get_state(device_data_pid)

  #   response = APICall.get!("/devices")
  #   expected_response = %{
  #     data: devices,
  #   } |> Poison.encode!

  #   assert response.status_code == 200
  #   assert response.body == expected_response
  # end

  # test "allow a user to register a device" do
  #   random_user = Fixtures.user
  #   create_user_payload = %{
  #     "user" => random_user,
  #   }
  #   created_user = APICall.post!("/users", create_user_payload)
  #   user_data = created_user.body |> Poison.decode!

  #   registration_payload = %{
  #     registration: %{
  #       mac_address: "00:12:34:56:78:90",
  #       user: user_data["data"]["id"],
  #     }
  #   }

  #   expected_status_code = 201
  #   registration = APICall.post!("/registration", registration_payload)
  #   # assert registration.status_code == expected_status_code
  #   assert registration.body == []
  # end
end
