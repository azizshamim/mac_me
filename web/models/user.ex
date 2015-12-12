defmodule MacMe.User do
  use MacMe.Web, :model

  @defaultAvatar "https://avatars1.githubusercontent.com/u/532584"

  schema "users" do
    field :irc_username, :string
    field :github_username, :string
    field :avatar_url, :string, default: @defaultAvatar

    has_many :devices, MacMe.Device

    timestamps
  end

  @required_fields ~w(irc_username)
  @optional_fields ~w(github_username avatar_url)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_url(:avatar_url)
  end

  defp validate_url(changeset, field, options \\ []) do
    validate_change changeset, field, fn _, url ->
      case url |> String.to_char_list |> :http_uri.parse do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || "invalid url: #{inspect msg}"}]
      end
    end
  end
end
