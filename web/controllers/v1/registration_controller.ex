require IEx

defmodule MacMe.V1.RegistrationController do
  @moduledoc """
  Main controller gathering all the data necessary for manipulating the
  Register model
  """
  use MacMe.Web, :controller
  alias MacMe.UserActions
  alias MacMe.DeviceActions

  plug :scrub_params, "registration" when action in [:create, :update]

  def create(conn, %{"registration" => registration_params}) do
    irc_username = registration_params["irc_username"]
    mac_address = registration_params["mac_address"]

    user = irc_username |> UserActions.query_by_irc_username
    user_params = %{irc_username: irc_username}
    device = mac_address |> DeviceActions.query_by_mac_address
    device_params = %{mac_address: mac_address}

    # Well, it's silly to have a user register a ton of things automatically
    # because it's just a username and a MAC. Maybe at some point this gets
    # done differently at some point in the future. Let's help our friends
    # out.
  #   case {user, device} do
  #     {[], []} ->
  #       conn
  #       |> attempt_user_registration(user_params)
  #       |> attempt_device_registration(device_params)
  #       |> create(%{"registration" => registration_params})
  #     {_, []} ->
  #       conn
  #       |> attempt_device_registration(device_params)
  #       |> create(%{"registration" => registration_params})
  #     {[], _} ->
  #       conn
  #       |> attempt_user_registration(user_params)
  #       |> create(%{"registration" => registration_params})
  #     {_, _}->
  #       conn
  #       |> register_user_device(user, device)
  #   end
  end

  defp attempt_device_registration(conn, device_params) do
    case DeviceActions.register_new_device(device_params) do
      {:ok, _} ->
        conn
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MacMe.ChangesetView, "error", changeset: changeset)
    end
  end

  defp attempt_user_registration(conn, user_params) do
    case UserAction.register_new_user(user_params) do
      {:ok, _} ->
        conn
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MacMe.ChangesetView, "error", changeset: changeset)
    end
  end

  defp register_user_device(conn, user, device) do
    case DeviceActions.register_user(device, user) do
      {:ok, device} ->
        conn
        |> render(MacMe.V1.RegistrationView, "register.json", device: device)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MacMe.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
