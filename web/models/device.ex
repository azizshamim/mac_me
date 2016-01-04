defmodule MacMe.Device do
  @moduledoc """
  This module defines the model for a Device, as it is stored
  in our database. Leverages Ecto in order to validate and store
  data.
  """
  use MacMe.Web, :model

  @mac_format ~r/([0-9A-F]{2}[:-]){5}([0-9A-F]{2})/

  schema "devices" do
    field :mac_address, :string
    field :name, :string

    belongs_to :user, MacMe.User
    timestamps
  end

  @required_fields ~w(mac_address)
  @optional_fields ~w(name)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:mac_address, @mac_format)
  end
end

defmodule MacMe.DeviceActions do
  import Ecto.Query
  alias MacMe.Device
  alias MacMe.Repo

  def query_by_mac_address(mac_address) do
    query = from r in Device,
    where: r.mac_address == ^mac_address,
    select: r
    Repo.all(query) |> List.first
  end

  def register_new_device(device_params) do
    %Device{}
    |> Device.changeset(device_params)
    |> Repo.insert
  end

  def register_user(device, user) do
    device_params = %{
      user_id: user.id,
    }

    device
    |> Device.changeset(device_params)
    |> Repo.update
    |> Repo.preload(:users)
  end
end
