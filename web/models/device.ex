defmodule MacMe.Device do
  use MacMe.Web, :model

  @mac_format ~r/([0-9A-F]{2}[:-]){5}([0-9A-F]{2})/

  schema "devices" do
    field :mac_address, :string

    belongs_to :user, MacMe.User
    timestamps
  end

  @required_fields ~w(mac_address)
  @optional_fields ~w()

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
